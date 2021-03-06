## gfxCardStatus
by Cody Krieger

gfxCardStatus is an open-source menu bar application for OS X that allows users
of dual GPU MacBook Pros to monitor the status of, and switch between said GPUs.

## Mod details

This is stripped down command line only version of gfxCardStatus by Cody Krieger.
To build:
```
cd /path/to/project/dir
xcodebuild
```

## Usage example: switch GPU immediately after login:

Create "/Library/LaunchAgents/com.nullvision.gfxCardStatusCLI.plist" (assuming gfxCardStatusCLI was coppied to '/usr/local/bin/'):
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.nullvision.gfxCardStatusCLI</string>
        <key>ProgramArguments</key>
        <array>
            <string>/usr/local/bin/gfxCardStatusCLI</string>
            <string>--integrated</string>
        </array>
		<key>RunAtLoad</key>
		<true/>
        <key>KeepAlive</key>
        <true/>
    </dict>
</plist>
```
Reboot. You can search for 'gfx' in Console.app to see if it works ;)


## License

Licensed under the New BSD License.

Copyright (c) 2010-2012, Cody Krieger
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:  
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.  
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.  
    * Neither the name of gfxCardStatus nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.  

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL CODY KRIEGER BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
