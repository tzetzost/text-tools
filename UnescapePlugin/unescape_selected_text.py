import sublime
import sublime_plugin
import re

class UnescapeSelectedTextCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        unescape_map = {
            '\\b': '\b',
            '\\f': '\f',
            '\\n': '\n',
            '\\r': '\r',
            '\\t': '\t',
            '\\"': '"',
            '\\\\': '\\'
        }

        # Combine all escape sequences into a single regex pattern
        escape_pattern = re.compile('|'.join(re.escape(k) for k in unescape_map.keys()))

        for region in self.view.sel():
            if not region.empty():
                selected_text = self.view.substr(region)
#                print("Selected text (raw):", repr(selected_text))  # Debug

                def replace_match(match):
                    key = match.group(0)
                    return unescape_map[key]

                unescaped_text = escape_pattern.sub(replace_match, selected_text)
#                print("Unescaped text:", repr(unescaped_text))  # Debug

                self.view.replace(edit, region, unescaped_text)
