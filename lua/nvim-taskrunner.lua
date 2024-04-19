local M = {}

local pick = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")

function M.setup(opts)
    vim.api.nvim_create_user_command("TR", function(args)

        pick.new({}, {
            prompt_title = "What to Run?",
            finder = finders.new_table {

                results = opts;

                entry_maker = function(e)
                    local act = e.action

                    if type(act) == "function" then
                        print("is function");
                        --[[ NOP ]]--
                    elseif type(act) == "string" then
                        print("is string");
                        e.action = function() vim.cmd("norm "..act) end;
                    else
                        print("has no function");
                        e.label = e.label .. " (no function)"
                        e.action = function() print("has no function") end;
                    end

                    return {
                        value = e.action,
                        display = e.label,
                        ordinal = e.label
                    }
                end
            },
            sorter = conf.generic_sorter({}),

            attach_mappings = function(promptBuffer, map)

                actions.select_default:replace(function()
                    -- make sure to close telescope first
                    actions.close(promptBuffer)

                    -- Grab, what was selected
                    local choice = actions_state.get_selected_entry();

                    if choice ~= nil and choice.value ~= nil then
                        choice.value()
                    end


                end)

                -- Confirm, that we want ot change the Telescope action
                return true;
            end
        }):find({
            
        })

    end, {
     
    });
end

return M
