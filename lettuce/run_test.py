# Copyright (C) 2013 Internet Systems Consortium.
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND INTERNET SYSTEMS CONSORTIUM
# DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
# INTERNET SYSTEMS CONSORTIUM BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING
# FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION
# WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# author: Wlodzimierz Wencel

from lettuce import Runner
import importlib
import optparse
import os
import sys

def option_parser():
    desc='''
    Forge version .... ? :)
    '''
    parser = optparse.OptionParser(description = desc, usage = "%prog or type %prog -h (--help) for help")
    parser.add_option("-4", "--version4",
                      dest = "version4",
                      action = "store_true",
                      default = False,
                      help = 'Declare IP version 4 tests')
    
    parser.add_option("-6", "--version6",
                      dest = "version6",
                      action = "store_true",
                      default = False,
                      help = "Declare IP version 6 tests")
    
    parser.add_option("-v", "--verbosity",
                      dest = "verbosity",
                      type = "int",
                      action = "store",
                      default = 4,
                      help = "Level of the lettuce verbosity")
    
    parser.add_option("-l", "--list",
                      dest = "list",
                      action = "store_true",
                      default = False,
                      help = 'List all features (test sets) please choose also IP version')

    parser.add_option("-s", "--test_set",
                      dest = "test_set",
                      action = "store",
                      default = None,
                      help = "Specific tests sets")
    
    parser.add_option("-n", "--name",
                      dest = "name",
                      default = None,
                      help = "Single scenario name, don't use that option with -s or -t")
    
    parser.add_option("-t", "--tags",
                      dest = "tag",
                      action = "append",
                      default = None,
                      help = "Specific tests tags, multiple tags after ',' e.g. -t v6,basic. If you wont specify any tags, Forge will perform all test for chosen IP version.")
    
    parser.add_option("-x", "--with-xunit",
                      dest = "enable_xunit",
                      action = "store_true",
                      default = False,
                      help = "Generate results file in xUnit format")

    (opts, args) = parser.parse_args()
    
    if not opts.version6 and not opts.version4:
        parser.print_help()
        parser.error("You must choose between -4 or -6.\n")
        
    if opts.version6 and opts.version4:
        parser.print_help()
        parser.error("options -4 and -6 are exclusive.\n")
        
    number = '6' if opts.version6 else '4'
    #Generate list of set tests and exit
    if opts.list:
        from help import UserHelp
        hlp = UserHelp()
        hlp.test(number, 0)
        sys.exit()
        
    from features.init_all import HISTORY
    if HISTORY:
        from help import TestHistory
        history = TestHistory()
        
    if opts.name is not None:
        from help import find_scenario
        base_path, scenario = find_scenario(opts.name, number)
        if base_path is None:
            print "Scenario named %s has been not found" %opts.name
            sys.exit()
    else:
        scenario = None
        
    #adding tags for lettuce
    if opts.tag is not None:
        tag = opts.tag[0].split(',')
    else:
        tag = 'v6' if opts.version6 else 'v4'
    
    #path for tests, all for specified IP version or only one set
    if opts.test_set is not None:
        path = "/features/tests_v" + number + "/" + opts.test_set + "/"
        base_path = os.getcwd() + path
    elif opts.name is not None:
        pass
    else:
        path = "/features/tests_v" + number + "/"
        base_path = os.getcwd() + path
        
    print base_path,scenario
    if HISTORY: history.start()
    #lettuce starter, adding options
    runner = Runner(
                    base_path,
                    verbosity = opts.verbosity,
                    scenarios = scenario,
                    failfast = False,
                    tags = tag,
                    enable_xunit = opts.enable_xunit)\
                     
    result = runner.run() #start lettuce
    
    #build report if requested
    if HISTORY: 
        try:
            history.information(result.scenarios_passed, result.scenarios_ran, tag, path)
            history.build_report()
        except:
            pass
        
def main():
    try :
        config = importlib.import_module("features.init_all")
    except ImportError:
        print "You need to create 'init_all.py' file with configuration! (example file: init_all.py_example)"
        sys.exit()
    if config.SERVER_TYPE == "":
        print "Please make sure your configuration is valid\nProject Forge shutting down."
        sys.exit()       
    option_parser()

if __name__ == '__main__':
    main()
