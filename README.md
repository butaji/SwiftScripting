# SwiftScripting
Utilities and samples to aid in using Swift with the Scripting Bridge

## Generating Swift API for a Target Application

The scripting approach leveraged here is a Swift layer on top of the [Scripting Bridge](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ScriptingBridgeConcepts/Introduction/Introduction.html).
OS X ships with a pair of utilities, `sdef` and `sdp`, to aid Objective-C programmers in using the Scripting Bridge.

The `sdef` tool is used to extract the scripting definition from an application. It emits the scripting 
definition to standard output in XML format. The `sdp` tool can be used to convert the XML emitted by
`sdef` to an Objective-C header file. This header file defines the scripting interface for a target application
exposed to Objective-C by the Scripting Bridge.

When scripting applications using Swift, it is possible to leverage the same Objective-C headers emitted by `sdp`. 
However, due to the dynamically generated classes involved in realizing the Scripting Bridge interface, this approach 
can be cumbersome and forces the use of `AnyObject` types even in areas when more specific types are known to
exist.

The approach here is to generate a set of Swift protocols based on the Objective-C header emitted by `sdp`. In most cases, 
the generated file can be used without modification. There are some corner cases where manual editing is required to 
correct issues or workaround bugs in the Swift compiler.

The basic recipe for generating the Swift protocols for a fictitious application called App.app is as follows

1. `sdef /Applications/App.app > App.sdef`
2. `sdp -fh --basename App App.sdef`
3. `sbhc.py App.h`

Step 1 will create the `App.sdef` file in the current directory. Step 2 will create a file `App.h`, also in the current
directory. The final step will create two additional files in the current directory: `App.swift` and `AppEnums.h`.

Note that the sbhc.py script leverages the [Python bindings](https://pypi.python.org/pypi/clang/3.5) for libclang.
You must install these bindings before running the script.
