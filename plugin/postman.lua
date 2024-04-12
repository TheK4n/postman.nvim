
local function get_line_index_under_cursor()
    local line_number_under_cursor, _ = unpack(vim.api.nvim_win_get_cursor(0))
    return line_number_under_cursor - 1
end

local function get_text_from_line(line_index)
    return vim.api.nvim_buf_get_lines(0, line_index, line_index+1, false)[1]
end


local function find_start_of_paragraph()
    local current_line_index = get_line_index_under_cursor()

    local start_finding_line_index = current_line_index

    while true do
        local current_line = get_text_from_line(start_finding_line_index)
        if current_line == "" or current_line == nil then
            return start_finding_line_index + 1
        end

        start_finding_line_index = start_finding_line_index - 1
    end
end

local function find_end_of_paragraph()
    local current_line_index = get_line_index_under_cursor()

    local start_finding_line_index = current_line_index

    while true do
        local current_line = get_text_from_line(start_finding_line_index)
        if current_line == "" or current_line == nil then
            return start_finding_line_index - 1
        end

        start_finding_line_index = start_finding_line_index + 1
    end
end

local function get_text_from_current_paragraph()
    local currentLine = get_text_from_line(get_line_index_under_cursor())
    if currentLine == "" or currentLine == nil then
        error("Blank line")
        return
    end

    local start_of_par = find_start_of_paragraph()
    local end_of_par = find_end_of_paragraph()

    local lines = vim.api.nvim_buf_get_lines(0, start_of_par, end_of_par+1, false)
    local result = table.concat(lines, " ")
    return result
end

function PostmanExec()
    local cmd = get_text_from_current_paragraph()
    vim.cmd("tabnew | norm I# " .. cmd)
    vim.cmd("norm o")
    vim.cmd("r ! " .. cmd)
end

vim.api.nvim_create_user_command("PostmanExec", PostmanExec, {})
vim.keymap.set("n", "<Leader>rl", PostmanExec)