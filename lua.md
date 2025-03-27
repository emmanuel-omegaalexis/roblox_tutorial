# Lua Cheat Sheet for Python Beginners

## 1. Basic Syntax
- **Case Sensitivity:**  
  Lua is case-sensitive just like Python.

- **Comments:**  
  - **Single-line:**  
    Lua uses `--`  
    ```lua
    -- This is a single-line comment in Lua
    ```
    Python uses `#`  
    ```python
    # This is a single-line comment in Python
    ```
  - **Multi-line:**  
    Lua uses `--[[ ... ]]`  
    ```lua
    --[[
      This is a multi-line comment
      in Lua.
    ]]
    ```

## 2. Variables and Data Types
- **Variable Declaration:**  
  Variables in Lua are global by default. Use `local` to create local variables.
  ```lua
  -- Global variable
  x = 10
  
  -- Local variable
  local y = 20
  ```

- **Basic Data Types:**  
  - **Numbers:**  
    ```lua
    local num = 42         -- integer or float
    ```
  - **Strings:**  
    ```lua
    local greeting = "Hello, Lua!"  -- can also use single quotes: 'Hello, Lua!'
    ```
  - **Booleans:**  
    ```lua
    local is_valid = true
    ```
  - **Nil:**  
    Represents the absence of a useful value.
    ```lua
    local nothing = nil
    ```

## 3. Functions
- **Defining Functions:**  
  In Lua, functions are first-class values.
  ```lua
  function add(a, b)
      return a + b
  end

  -- Anonymous function assigned to a variable
  local subtract = function(a, b)
      return a - b
  end
  ```
  *Python equivalent:*
  ```python
  def add(a, b):
      return a + b

  subtract = lambda a, b: a - b
  ```

## 4. Control Structures
- **If Statements:**
  ```lua
  if condition then
      -- code block
  elseif another_condition then
      -- another block
  else
      -- fallback block
  end
  ```
  *Python equivalent:*
  ```python
  if condition:
      # code block
  elif another_condition:
      # another block
  else:
      # fallback block
  ```

- **Loops:**
  - **While Loop:**
    ```lua
    local i = 1
    while i <= 5 do
        print(i)
        i = i + 1
    end
    ```
    *Python equivalent:*
    ```python
    i = 1
    while i <= 5:
        print(i)
        i += 1
    ```
    
  - **For Loop (Numeric):**
    ```lua
    for i = 1, 5 do
        print(i)
    end
    ```
    *Python equivalent:*
    ```python
    for i in range(1, 6):
        print(i)
    ```

  - **Generic For Loop (Iterating over tables):**
    ```lua
    local fruits = {"apple", "banana", "cherry"}
    for index, value in ipairs(fruits) do
        print(index, value)
    end
    ```
    *Python equivalent:*
    ```python
    fruits = ["apple", "banana", "cherry"]
    for index, value in enumerate(fruits, start=1):
        print(index, value)
    ```

## 5. Tables (Lua’s Only Data Structure)
Tables are versatile and can act as arrays, dictionaries, or objects.
- **Array-like Tables:**
  ```lua
  local numbers = {10, 20, 30}
  print(numbers[1])  -- Lua arrays are 1-indexed (first element is numbers[1])
  ```
- **Dictionary-like Tables:**
  ```lua
  local person = {name = "Alice", age = 30}
  print(person.name)  -- Access using the dot notation
  print(person["age"])  -- Or using bracket notation
  ```
- **Mixed Tables:**
  ```lua
  local mixed = {1, 2, key = "value", [10] = "ten"}
  ```

## 6. Functions as First-Class Citizens
Lua treats functions as values, which means you can pass them as arguments, store them in variables, etc.
```lua
function sayHello(name)
    print("Hello, " .. name)
end

local greeter = sayHello
greeter("Lua")  -- Outputs: Hello, Lua
```

## 7. Error Handling
Lua uses `pcall` (protected call) for error handling.
```lua
local status, err = pcall(function()
    error("Something went wrong!")
end)
if not status then
    print("Error: " .. err)
end
```
*Python equivalent:*
```python
try:
    raise Exception("Something went wrong!")
except Exception as e:
    print("Error:", e)
```

## 8. Modules and Libraries
- **Modules:**  
  Use `require` to include external modules.
  ```lua
  local socket = require("socket")
  ```
- Lua has a standard library for many tasks (string manipulation, table operations, math, I/O, etc.).

## 9. Differences to Note (Python vs. Lua)
- **Indexing:**  
  Lua arrays are 1-indexed, whereas Python lists are 0-indexed.
- **Syntax:**  
  Lua uses `end` to close blocks (functions, if-statements, loops), while Python uses indentation.
- **Variable Scope:**  
  Variables are global by default in Lua unless declared with `local`.
- **Tables vs. Lists/Dictionaries:**  
  Lua has one versatile structure (tables) that combines features of Python lists and dictionaries.

---

This cheat sheet provides a quick overview of Lua syntax and concepts for someone coming from Python. Experiment with small scripts and consult the [Lua Reference Manual](https://www.lua.org/manual/5.4/) for more details as you advance.
