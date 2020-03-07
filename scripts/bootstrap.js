const fs = require("fs");
const path = require("path");
const IGNORE_GLOBAL_HOOKS_PATH = path.join(__dirname, "../IGNORE_GLOBAL_HOOKS");
console.log("  ▶ Run Bootstrap");
if (!fs.existsSync(IGNORE_GLOBAL_HOOKS_PATH)) {
    console.log("  ▶ Create IGNORE_GLOBAL_HOOKS");
    const GIT_HOOK_ABSOLUTE_PATH = path.resolve(__dirname, "../");
    fs.writeFileSync(IGNORE_GLOBAL_HOOKS_PATH, `${GIT_HOOK_ABSOLUTE_PATH}\n`, "utf-8");
} else {
    console.log("  ▶ Already has IGNORE_GLOBAL_HOOKS");
}
