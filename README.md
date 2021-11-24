# rbx2dc-proxy
Roblox to Discord proxy as Roblox headers got banned by them (troll)
it's used for webhooks btw

I host this project on [Heroku](https://www.heroku.com/home "Heroku"), feel free to use it.

## How to use it
### Install the following packages
- express to receive requests from Roblox
- needle to send requests to Discord

If you use NPM for example, then simply run `npm i needle` and `npm i express`
## How to use it on Roblox
### Enable HTTP Requests
Go to the HOME tab then click the toothed wheel "Game Settings" ![Toolbar](https://raw.githubusercontent.com/dinat13/rbx2dc-proxy/master/assets/toolbar.png)

Once opened, go to the Security tab then and enable HTTP Requests ![Settings](https://raw.githubusercontent.com/dinat13/rbx2dc-proxy/master/assets/settings.png)

### Add the module

Create a ModuleScript called "DCProxy" in ServerScriptService with the code below, download [this](https://github.com/dinat13/rbx2dc-proxy/releases/download/Test/DCProxy.lua "Lua file") (don't forget to turn it in a ModuleScript) or get it [here](thelinktorbxmodule)

### Create a server-sided script
Your script needs to be server-sided, so you will have to create the script in the Workspace or the ServerScriptService.

All the functions can be found inside the ModuleScript