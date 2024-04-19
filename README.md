# NVIM - TaskRunner 

a simple Plugin, that allows for choosing and starting custom functions via a Telescope List.

## Requires
https://github.com/nvim-telescope/telescope.nvim
https://github.com/nvim-lua/plenary.nvim (dependency of Telescope)

## Usage
Once installed, vim gets a new command called `TR`.
So simply type `:TR` in normal mode and your configured list will open.


## Configuration
Speaking of configured list. You configure that list during the setup process.

via Lazy.nvim (https://github.com/folke/lazy.nvim) that setup would look like this.
```lua
{
    "rocco-gossmann/nvim-taskrunner",
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    init = function()

        require("nvim-taskrunner").setup({
            --[[ Define your tasks in here, each task is one entry ]]--

            {
                --[[ The `label` is shown in Telescope ]]--
                label = "Go return err nil",


                --[[ `action` is a function, that is executed, when you
                              choose the task via Telescope 
                ]]
                action = function()
                    vim.api.nvim_put({
                        "if err != nil {", 
                        "\treturn err",
                        "}" 
                    }, "", true, false)
                end

                --[[ 
                    The `action` can also be a VIM-Macro-String, (executed via vim.cmd.normal)
                    type `:h normal` in NeoVim to get more info on how the 
                    syntax of these strings works.

                    All Macros start from Normal mode.

                    A Macro-Action may look like this: 

                    action = "oif err != nil {^[oreturn err^[o}^[o",

                    the ` ^[ ` is the <ESC> character.  you must input that via <C-v><ESC>
                    (Just copying this string will not work)
                ]]--
            },
        })
    end

}
```
