# 🚀 Terraform Expressions

<p align="center">
  <img src="https://img.shields.io/badge/IaC-Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform Badge">
  <img src="https://img.shields.io/badge/Language-HCL-844FBA?style=for-the-badge" alt="HCL Badge">
  <img src="https://img.shields.io/badge/Level-Beginner%20to%20Advanced-2EA44F?style=for-the-badge" alt="Learning Level">
  <img src="https://img.shields.io/badge/Examples-Included-0078D4?style=for-the-badge" alt="Examples Included">
</p>

<p align="center">
  <b>📘 A Complete Guide to Terraform Expressions, Operators, Functions, Collections, and Dynamic Configuration</b>
</p>

---

## 📚 Table of Contents

1. [🎯 Introduction to Terraform Expressions](#-1-introduction-to-terraform-expressions)
2. [🔤 Literal Expressions](#-2-literal-expressions)
3. [🔗 References and Named Values](#-3-references-and-named-values)
4. [➕ Arithmetic Expressions](#-4-arithmetic-expressions)
5. [⚖️ Comparison Expressions](#-5-comparison-expressions)
6. [🧠 Logical Expressions](#-6-logical-expressions)
7. [🔀 Conditional Expressions](#-7-conditional-expressions)
8. [📝 String Expressions and Templates](#-8-string-expressions-and-templates)
9. [📦 Collection and Structural Expressions](#-9-collection-and-structural-expressions)
10. [🎯 Indexing and Element Access](#-10-indexing-and-element-access)
11. [🏷️ Attribute Access Expressions](#-11-attribute-access-expressions)
12. [🔁 For Expressions](#-12-for-expressions)
13. [🌟 Splat Expressions](#-13-splat-expressions)
14. [🛠️ Function Calls and Built-in Functions](#-14-function-calls-and-built-in-functions)
15. [🔄 Type Conversion Expressions](#-15-type-conversion-expressions)
16. [🧩 Parentheses and Expression Grouping](#-16-parentheses-and-expression-grouping)
17. [🏗️ Practical Usage: `count` and `for_each`](#-17-practical-usage-count-and-for_each)
18. [🌍 Real-World Terraform Example](#-18-real-world-terraform-example)
19. [📖 Quick Function Reference](#-19-quick-function-reference)
20. [⚠️ Common Mistakes](#-20-common-mistakes)
21. [✅ Best Practices](#-21-best-practices)
22. [🎤 Terraform Expressions Interview Questions](#-22-terraform-expressions-interview-questions)
23. [📌 Additional Terraform Topics](#-23-additional-terraform-topics)
24. [🔗 Official Documentation](#-24-official-documentation)

---

# 🎯 1. Introduction to Terraform Expressions

## 📌 What Is a Terraform Expression?

A Terraform expression is a combination of literal values, references, operators, function calls, or other expressions that Terraform evaluates to produce a value.

Expressions help you create reusable, dynamic, conditional, and data-driven infrastructure configurations instead of hardcoding every setting.

### 💡 Example

```hcl
variable "environment" {
  type    = string
  default = "dev"
}

locals {
  instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"
}
```

### 📤 Expected Output

For the default environment:

```text
local.instance_type = "t3.micro"
```

### 🎯 Use Cases

- Select instance types according to an environment.
- Generate resource names dynamically.
- Transform lists into maps.
- Filter resources based on conditions.
- Calculate infrastructure settings.
- Reuse values across multiple resources.
- Avoid unnecessary hardcoding.

## 🧩 The 16 Main Topics

| # | Topic | Purpose |
|---:|---|---|
| 1 | Literal Expressions | Represent fixed values |
| 2 | References | Access variables, locals, resources, and modules |
| 3 | Arithmetic Expressions | Perform mathematical calculations |
| 4 | Comparison Expressions | Compare values |
| 5 | Logical Expressions | Combine Boolean conditions |
| 6 | Conditional Expressions | Select values based on conditions |
| 7 | String Expressions | Build dynamic text |
| 8 | Collection Expressions | Create lists, sets, tuples, objects, and maps |
| 9 | Indexing Expressions | Access collection elements |
| 10 | Attribute Access | Retrieve named attributes |
| 11 | For Expressions | Transform and filter collections |
| 12 | Splat Expressions | Retrieve attributes from multiple elements |
| 13 | Function Calls | Use Terraform's built-in functions |
| 14 | Type Conversion | Convert values between types |
| 15 | Parentheses | Group expressions and control evaluation order |
| 16 | `count` and `for_each` | Use expressions to control resource instances |

> 💡 **Important:** `count` and `for_each` are Terraform meta-arguments, not expression operators. They are included as a separate practical topic because expressions commonly determine their values.

---

# 🔤 2. Literal Expressions

Literal expressions represent values written directly in configuration. Terraform evaluates these values without needing to look up a variable or calculate a result from another expression.

## 2.1 📝 String Literal

A string literal represents text enclosed in double quotation marks. Terraform uses string values for names, descriptions, regions, tags, identifiers, and other textual configuration settings.

### 💻 Code

```hcl
locals {
  environment = "dev"
  region      = "ap-south-1"
}
```

### 📤 Output

```text
local.environment = "dev"
local.region      = "ap-south-1"
```

### 🎯 Use Case

Use string literals for environment names, AWS regions, resource tags, and fixed descriptions.

---

## 2.2 🔢 Number Literal

A number literal represents a numeric value written directly in an expression. Terraform supports whole numbers and decimal numbers for calculations, configuration values, limits, and numeric comparisons.

### 💻 Code

```hcl
locals {
  instance_count = 3
  storage_size   = 20
  discount       = 2.5
}
```

### 📤 Output

```text
local.instance_count = 3
local.storage_size   = 20
local.discount       = 2.5
```

### 🎯 Use Case

Use number literals for storage sizes, counts, port numbers, and other numeric settings.

---

## 2.3 ✅ Boolean Literal

A Boolean literal represents one of two logical values: `true` or `false`. Terraform uses Boolean values to enable or disable features and evaluate logical or conditional expressions.

### 💻 Code

```hcl
locals {
  enable_monitoring = true
  enable_deletion   = false
}
```

### 📤 Output

```text
local.enable_monitoring = true
local.enable_deletion   = false
```

### 🎯 Use Case

Use Boolean values for monitoring, optional features, and configuration flags.

---

## 2.4 🚫 Null Literal

The `null` literal represents the absence of a value. Depending on the argument and resource schema, assigning `null` can behave like omitting an optional argument rather than providing a concrete value.

### 💻 Code

```hcl
variable "description" {
  type    = string
  default = null
}
```

### 📤 Output

```text
var.description = null
```

### 🎯 Use Case

Use `null` when an optional configuration value should remain unspecified.

> ⚠️ `null` does not mean an empty string (`""`), zero (`0`), or Boolean `false`.

---

# 🔗 3. References and Named Values

References allow expressions to read values from variables, local values, resources, data sources, and modules. They are essential for connecting configuration components and creating dependency relationships between infrastructure resources.

## 3.1 📥 Input Variable Reference — `var`

The `var` namespace accesses input variables declared using `variable` blocks. Referencing an input variable allows configuration values to be supplied through defaults, variable files, environment variables, or command-line options.

### 💻 Code

```hcl
variable "environment" {
  type    = string
  default = "dev"
}

output "current_environment" {
  value = var.environment
}
```

### 📤 Output

```text
current_environment = "dev"
```

### 🎯 Use Case

Use `var` to make configurations reusable across development, testing, staging, and production environments.

---

## 3.2 📦 Local Value Reference — `local`

The `local` namespace accesses individual local values declared inside a `locals` block. Local values simplify complex expressions by assigning meaningful names to calculated or repeatedly used configuration values.

### 💻 Code

```hcl
locals {
  project     = "payment"
  environment = "dev"
  name        = "${local.project}-${local.environment}"
}

output "resource_name" {
  value = local.name
}
```

### 📤 Output

```text
resource_name = "payment-dev"
```

### 🎯 Use Case

Use `local` to centralize naming conventions, common tags, and repeated calculations.

> 📝 The declaration block is named `locals`, but individual values are referenced using `local.<name>`.

---

## 3.3 🏗️ Resource Reference

A resource reference accesses an attribute of a managed resource using its resource type and local resource name. Terraform uses these references to connect resources and determine dependencies between infrastructure components.

### 💻 Code

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

output "vpc_id" {
  value = aws_vpc.main.id
}
```

### 📤 Expected Output

```text
vpc_id = "vpc-xxxxxxxx"
```

The actual identifier is assigned by AWS and will differ between deployments.

### 🎯 Use Case

Use resource references when passing a VPC ID to a subnet, a security group ID to another resource, or an instance ID to an output.

---

## 3.4 📊 Data Source Reference

A data source reference accesses information retrieved from an existing resource or external system. Unlike a managed resource declaration, a data source generally reads information instead of creating the infrastructure it describes.

### 💻 Code

```hcl
data "aws_vpc" "existing" {
  id = "vpc-0123456789abcdef0"
}

output "existing_vpc_cidr" {
  value = data.aws_vpc.existing.cidr_block
}
```

### 📤 Expected Output

```text
existing_vpc_cidr = "10.0.0.0/16"
```

This output assumes the specified VPC exists and is accessible.

### 🎯 Use Case

Use data sources to retrieve existing VPCs, AMIs, subnets, availability zones, and other information.

---

## 3.5 📦 Module Output Reference

A module output reference accesses a value explicitly exposed by a child module. This lets a root module consume selected information from reusable infrastructure components without directly referencing their internal implementation.

### 💻 Code

```hcl
module "network" {
  source = "./modules/network"
}

output "network_vpc_id" {
  value = module.network.vpc_id
}
```

The child module must declare an output named `vpc_id`.

### 📤 Expected Output

```text
network_vpc_id = "vpc-xxxxxxxx"
```

### 🎯 Use Case

Use module outputs to share VPC IDs, subnet IDs, security group IDs, and other required values between modules.

---

# ➕ 4. Arithmetic Expressions

Arithmetic expressions perform mathematical calculations on numeric values. Terraform supports addition, subtraction, multiplication, division, and remainder operations, which are useful for deriving configuration values.

## 4.1 ➕ Addition — `+`

The addition operator combines two numeric operands into their mathematical sum. Both operands must be compatible numeric values, making the operator useful for totals, offsets, and calculated capacity settings.

### 💻 Code

```hcl
locals {
  total_storage = 20 + 30
}
```

### 📤 Output

```text
total_storage = 50
```

### 🎯 Use Case

Calculate combined storage capacities or total quantities.

---

## 4.2 ➖ Subtraction — `-`

The subtraction operator calculates the difference between two numeric operands. Terraform evaluates the right operand against the left operand, making subtraction useful for remaining capacity and numeric adjustments.

### 💻 Code

```hcl
locals {
  remaining_capacity = 100 - 35
}
```

### 📤 Output

```text
remaining_capacity = 65
```

### 🎯 Use Case

Calculate remaining storage, available capacity, or a difference between numeric settings.

---

## 4.3 ✖️ Multiplication — `*`

The multiplication operator multiplies two numeric operands and returns their product. It is useful when deriving total capacity, scaling quantities, or calculating a combined value from a repeated number of units.

### 💻 Code

```hcl
locals {
  total_gb = 3 * 20
}
```

### 📤 Output

```text
total_gb = 60
```

### 🎯 Use Case

Calculate total storage for three volumes of 20 GB each.

---

## 4.4 ➗ Division — `/`

The division operator divides the left numeric operand by the right numeric operand. The result can contain a fractional component, and the divisor must not be zero.

### 💻 Code

```hcl
locals {
  average_capacity = 100 / 4
}
```

### 📤 Output

```text
average_capacity = 25
```

### 🎯 Use Case

Calculate average capacity or distribute a numeric quantity across equal groups.

---

## 4.5 ♻️ Remainder — `%`

The remainder operator returns the remainder left after dividing one integer-like numeric value by another. It is useful for cyclic patterns, divisibility checks, and grouping calculations where whole-number arithmetic is appropriate.

### 💻 Code

```hcl
locals {
  remainder = 10 % 3
}
```

### 📤 Output

```text
remainder = 1
```

### 🎯 Use Case

Check whether a number is divisible by another number or determine a repeating numeric position.

> ⚠️ Division by zero and incompatible operands cause evaluation errors.

---

# ⚖️ 5. Comparison Expressions

Comparison expressions compare two values and produce a Boolean result. Terraform uses them in conditional expressions, filtering, validation, and logical combinations.

## 5.1 Equal To — `==`

The equality operator evaluates whether two operands have equal values after Terraform applies the language's type and comparison rules. It returns `true` when they compare equal and `false` otherwise.

### 💻 Code

```hcl
locals {
  is_production = "prod" == "prod"
}
```

### 📤 Output

```text
is_production = true
```

### 🎯 Use Case

Check whether an environment matches `"prod"`.

---

## 5.2 Not Equal To — `!=`

The inequality operator checks whether two operands are different. It returns `true` when the operands are not equal and `false` when they compare equal under Terraform's expression rules.

### 💻 Code

```hcl
locals {
  is_not_production = "dev" != "prod"
}
```

### 📤 Output

```text
is_not_production = true
```

### 🎯 Use Case

Apply settings when an environment is not production.

---

## 5.3 Greater Than — `>`

The greater-than operator compares two compatible numeric values and returns `true` when the left operand exceeds the right operand. Otherwise, the comparison returns `false`.

### 💻 Code

```hcl
locals {
  enough_storage = 100 > 50
}
```

### 📤 Output

```text
enough_storage = true
```

### 🎯 Use Case

Check whether a configured capacity exceeds a threshold.

---

## 5.4 Less Than — `<`

The less-than operator returns `true` when the left numeric operand is smaller than the right operand. It is useful for threshold checks and decisions based on numeric limits.

### 💻 Code

```hcl
locals {
  low_capacity = 10 < 20
}
```

### 📤 Output

```text
low_capacity = true
```

### 🎯 Use Case

Identify values below a configured capacity threshold.

---

## 5.5 Greater Than or Equal To — `>=`

The greater-than-or-equal operator returns `true` when the left numeric value is greater than or equal to the right numeric value. It includes equality as a valid match.

### 💻 Code

```hcl
locals {
  meets_minimum = 20 >= 20
}
```

### 📤 Output

```text
meets_minimum = true
```

### 🎯 Use Case

Check whether a capacity satisfies a minimum requirement.

---

## 5.6 Less Than or Equal To — `<=`

The less-than-or-equal operator returns `true` when the left numeric operand is smaller than or equal to the right operand. It is useful for maximum limits and boundary conditions.

### 💻 Code

```hcl
locals {
  within_limit = 50 <= 100
}
```

### 📤 Output

```text
within_limit = true
```

### 🎯 Use Case

Check whether a configured value remains within an allowed maximum.

---

# 🧠 6. Logical Expressions

Logical expressions combine or invert Boolean values. They allow Terraform to evaluate multiple requirements together before choosing a configuration value or deciding whether a condition is satisfied.

## 6.1 Logical AND — `&&`

The logical AND operator returns `true` only when both Boolean operands are true. It is useful when a configuration requires multiple independent conditions to be satisfied simultaneously.

### 💻 Code

```hcl
locals {
  deploy_allowed = true && true
}
```

### 📤 Output

```text
deploy_allowed = true
```

### 🎯 Use Case

Require both an approved environment and an enabled deployment flag.

---

## 6.2 Logical OR — `||`

The logical OR operator returns `true` when at least one Boolean operand is true. It allows a configuration condition to be satisfied through either of multiple acceptable alternatives.

### 💻 Code

```hcl
locals {
  access_allowed = false || true
}
```

### 📤 Output

```text
access_allowed = true
```

### 🎯 Use Case

Enable a feature when either of two supported conditions is met.

---

## 6.3 Logical NOT — `!`

The logical NOT operator reverses a Boolean value, changing `true` to `false` and `false` to `true`. It is useful for expressing negative conditions and disabling features.

### 💻 Code

```hcl
locals {
  disabled = !true
}
```

### 📤 Output

```text
disabled = false
```

### 🎯 Use Case

Invert a Boolean flag when a configuration needs the opposite condition.

---

## 6.4 `alltrue()` Function

`alltrue()` accepts a collection of Boolean values and returns `true` when every element is true. It returns `true` for an empty collection, following the mathematical convention for universal conditions.

### 💻 Code

```hcl
locals {
  checks_passed = alltrue([
    true,
    true,
    true
  ])
}
```

### 📤 Output

```text
checks_passed = true
```

### 🎯 Use Case

Check whether every required configuration condition has passed.

---

## 6.5 `anytrue()` Function

`anytrue()` accepts a collection of Boolean values and returns `true` when at least one element is true. It returns `false` when no element is true, including when the collection is empty.

### 💻 Code

```hcl
locals {
  any_enabled = anytrue([
    false,
    true,
    false
  ])
}
```

### 📤 Output

```text
any_enabled = true
```

### 🎯 Use Case

Determine whether at least one optional feature is enabled.

---

# 🔀 7. Conditional Expressions

A conditional expression selects one of two values according to a Boolean condition. Its syntax is `condition ? true_value : false_value`, allowing dynamic configuration without duplicating resource blocks.

## 7.1 Basic Conditional Operator — `? :`

The conditional operator evaluates a Boolean condition and selects the corresponding result expression. Both result branches should produce compatible values so Terraform can determine the expression's resulting type.

### 💻 Code

```hcl
variable "environment" {
  type    = string
  default = "prod"
}

locals {
  instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"
}
```

### 📤 Output

```text
local.instance_type = "t3.large"
```

### 🎯 Use Case

Select larger instance types for production and smaller instance types for development.

---

## 7.2 Nested Conditional Expressions

A nested conditional places another conditional inside one of the result branches. It supports multiple alternatives, but excessive nesting can reduce readability and should be replaced with clearer structures when possible.

### 💻 Code

```hcl
variable "environment" {
  type    = string
  default = "staging"
}

locals {
  instance_type = var.environment == "prod" ? "t3.large" : (
    var.environment == "staging" ? "t3.medium" : "t3.micro"
  )
}
```

### 📤 Output

```text
local.instance_type = "t3.medium"
```

### 🎯 Use Case

Choose different instance types for production, staging, and development.

---

## 7.3 Conditional Resource Creation

A conditional expression can determine whether a resource's `count` is zero or one. This pattern creates a resource when a condition is true and omits its instance when the condition is false.

### 💻 Code

```hcl
variable "create_bucket" {
  type    = bool
  default = true
}

resource "aws_s3_bucket" "example" {
  count  = var.create_bucket ? 1 : 0
  bucket = "example-terraform-bucket-12345"
}
```

### 📤 Expected Behavior

```text
create_bucket = true  -> 1 bucket instance
create_bucket = false -> 0 bucket instances
```

The bucket name must be globally unique and satisfy AWS S3 naming requirements.

### 🎯 Use Case

Optionally create S3 buckets, monitoring resources, or other infrastructure.

---

# 📝 8. String Expressions and Templates

String expressions construct text dynamically by combining literal text with values from variables, locals, or other expressions. Terraform supports interpolation, directives, multiline templates, and common string functions.

## 8.1 String Interpolation — `${}`

String interpolation embeds an expression's evaluated value inside a quoted string. It is useful for generating names, descriptions, paths, and other text containing dynamic configuration values.

### 💻 Code

```hcl
variable "environment" {
  type    = string
  default = "dev"
}

locals {
  bucket_name = "company-${var.environment}-logs"
}
```

### 📤 Output

```text
local.bucket_name = "company-dev-logs"
```

### 🎯 Use Case

Create environment-specific resource names.

> 💡 In modern Terraform, simple references can often be written directly. Interpolation remains useful when combining values with surrounding text.

---

## 8.2 String Concatenation — `join()`

`join()` combines a list of strings into one string, inserting the specified separator between elements. It is useful when a provider argument or output requires a single string rather than a collection.

### 💻 Code

```hcl
locals {
  resource_name = join("-", [
    "company",
    "payment",
    "dev"
  ])
}
```

### 📤 Output

```text
resource_name = "company-payment-dev"
```

### 🎯 Use Case

Construct resource names from several text components.

---

## 8.3 `format()` Function

`format()` creates a string using a format template and supplied arguments. It supports placeholders for common value types, helping developers produce consistent names, messages, and identifiers.

### 💻 Code

```hcl
locals {
  server_name = format("%s-%s-%02d", "web", "dev", 1)
}
```

### 📤 Output

```text
server_name = "web-dev-01"
```

### 🎯 Use Case

Generate standardized server names with padded numeric suffixes.

---

## 8.4 `upper()` Function

`upper()` converts every alphabetic character in a string to uppercase while leaving other characters unchanged. It is useful for formatting labels, generated identifiers, and environment descriptions.

### 💻 Code

```hcl
locals {
  environment = upper("production")
}
```

### 📤 Output

```text
environment = "PRODUCTION"
```

### 🎯 Use Case

Normalize environment labels for display or naming conventions.

---

## 8.5 `lower()` Function

`lower()` converts every alphabetic character in a string to lowercase. It is useful for normalizing user-provided text and constructing consistent identifiers where lowercase letters are preferred or required.

### 💻 Code

```hcl
locals {
  environment = lower("PRODUCTION")
}
```

### 📤 Output

```text
environment = "production"
```

### 🎯 Use Case

Normalize input values before constructing resource names.

---

## 8.6 `title()` Function

`title()` converts the first letter of each word to uppercase and adjusts the remaining letters according to Terraform's title-case behavior. It is mainly useful for readable labels and human-facing descriptions.

### 💻 Code

```hcl
locals {
  display_name = title("cloud infrastructure team")
}
```

### 📤 Output

```text
display_name = "Cloud Infrastructure Team"
```

### 🎯 Use Case

Format descriptive labels and display names.

---

## 8.7 `trimspace()` Function

`trimspace()` removes leading and trailing whitespace from a string. It helps normalize values that may contain accidental spaces or line breaks before they are used in names or comparisons.

### 💻 Code

```hcl
locals {
  environment = trimspace("  production  ")
}
```

### 📤 Output

```text
environment = "production"
```

### 🎯 Use Case

Clean whitespace around configuration input.

---

## 8.8 `replace()` Function

`replace()` searches a string for a specified substring or supported regular-expression pattern and replaces matching text. It helps transform naming conventions and normalize input strings.

### 💻 Code

```hcl
locals {
  resource_name = replace("payment_service", "_", "-")
}
```

### 📤 Output

```text
resource_name = "payment-service"
```

### 🎯 Use Case

Replace underscores with hyphens in generated names.

---

## 8.9 Heredoc Multiline Strings — `<<EOF`

A heredoc expression represents a multiline string without requiring every line to be individually quoted. It is useful for policies, scripts, configuration files, and templates embedded in Terraform.

### 💻 Code

```hcl
locals {
  startup_script = <<-EOF
    #!/bin/bash
    echo "Hello Terraform"
    echo "Environment: dev"
  EOF
}
```

### 📤 Output

```text
#!/bin/bash
echo "Hello Terraform"
echo "Environment: dev"
```

### 🎯 Use Case

Store multiline shell scripts, configuration files, and policy documents.

> 📝 `<<-EOF` allows Terraform to remove common indentation from the heredoc content.

---

## 8.10 Template Directives — `%{}`

Template directives control conditional output or repetition within Terraform strings. They allow a template to include or omit text based on expressions and to generate repeated text from collection elements.

### 💻 Code

```hcl
variable "environment" {
  type    = string
  default = "prod"
}

locals {
  message = <<-EOF
    %{ if var.environment == "prod" }
    Production environment enabled.
    %{ else }
    Non-production environment enabled.
    %{ endif }
  EOF
}
```

### 📤 Expected Output

```text
Production environment enabled.
```

### 🎯 Use Case

Generate scripts or configuration files that contain environment-specific sections.

---

# 📦 9. Collection and Structural Expressions

Collection and structural expressions group related values into lists, tuples, sets, maps, and objects. They enable Terraform configurations to represent multiple resources, structured settings, and reusable data.

## 9.1 List

A list is an ordered collection whose elements share a common type. Lists preserve element order and allow access through numeric indexes, making them suitable for ordered values and repeated configuration items.

### 💻 Code

```hcl
locals {
  regions = [
    "ap-south-1",
    "us-east-1",
    "eu-west-1"
  ]
}
```

### 📤 Output

```text
local.regions = [
  "ap-south-1",
  "us-east-1",
  "eu-west-1"
]
```

### 🎯 Use Case

Store ordered availability zones, subnet CIDRs, or environment names.

---

## 9.2 Tuple

A tuple is an ordered structural value whose elements can have different types at different positions. Unlike a list, a tuple describes each element's type separately and can represent heterogeneous sequences.

### 💻 Code

```hcl
locals {
  server_details = [
    "web-server",
    8080,
    true
  ]
}
```

### 📤 Output

```text
local.server_details = [
  "web-server",
  8080,
  true
]
```

### 🎯 Use Case

Represent a fixed sequence of values with different types, although objects are often clearer for named fields.

---

## 9.3 Set

A set is an unordered collection of unique elements of a compatible type. It removes duplicate values and does not guarantee the positional ordering provided by lists or tuples.

### 💻 Code

```hcl
locals {
  unique_regions = toset([
    "ap-south-1",
    "us-east-1",
    "ap-south-1"
  ])
}
```

### 📤 Output

```text
local.unique_regions = toset([
  "ap-south-1",
  "us-east-1"
])
```

The displayed order of set elements is not guaranteed.

### 🎯 Use Case

Represent unique values when duplicates are unnecessary.

---

## 9.4 Map

A map is a collection of values associated with string keys, with all values sharing a compatible type. Maps are useful for key-value configuration, environment settings, and tag collections.

### 💻 Code

```hcl
locals {
  instance_types = {
    dev  = "t3.micro"
    test = "t3.small"
    prod = "t3.large"
  }
}
```

### 📤 Output

```text
local.instance_types = {
  dev  = "t3.micro"
  test = "t3.small"
  prod = "t3.large"
}
```

### 🎯 Use Case

Select instance types or other settings by environment.

---

## 9.5 Object

An object is a structural value containing named attributes, where each attribute can have its own type. Objects are suitable for representing structured configuration such as server settings, networking details, and application metadata.

### 💻 Code

```hcl
locals {
  server = {
    name          = "web"
    instance_type = "t3.micro"
    monitoring    = true
  }
}
```

### 📤 Output

```text
local.server = {
  name          = "web"
  instance_type = "t3.micro"
  monitoring    = true
}
```

### 🎯 Use Case

Group related configuration fields into one named structure.

---

## 9.6 Empty Collection

An empty collection contains no elements, but its intended type can still matter in Terraform. Explicit type conversions can prevent type-inference problems when empty values are used in conditional expressions or resource arguments.

### 💻 Code

```hcl
locals {
  empty_list = tolist([])
  empty_set  = toset([])
  empty_map  = tomap({})
}
```

### 📤 Output

```text
local.empty_list = []
local.empty_set  = toset([])
local.empty_map  = {}
```

### 🎯 Use Case

Provide correctly typed empty values for optional collections.

---

## 9.7 `merge()` Function

`merge()` combines two or more maps or objects into one result. When multiple inputs contain the same key, the value from the rightmost argument takes precedence over earlier values.

### 💻 Code

```hcl
locals {
  common_tags = {
    Project = "Payment"
    Owner   = "CloudTeam"
  }

  environment_tags = {
    Environment = "dev"
    Owner       = "DevOps"
  }

  final_tags = merge(
    local.common_tags,
    local.environment_tags
  )
}
```

### 📤 Output

```text
final_tags = {
  Project     = "Payment"
  Owner       = "DevOps"
  Environment = "dev"
}
```

### 🎯 Use Case

Combine common tags with environment-specific tags.

---

## 9.8 `concat()` Function

`concat()` combines multiple lists or tuples into one sequence while preserving the order of their elements. It is useful when building a collection from separate groups of related values.

### 💻 Code

```hcl
locals {
  first_group  = ["subnet-a", "subnet-b"]
  second_group = ["subnet-c"]

  all_subnets = concat(
    local.first_group,
    local.second_group
  )
}
```

### 📤 Output

```text
all_subnets = [
  "subnet-a",
  "subnet-b",
  "subnet-c"
]
```

### 🎯 Use Case

Combine subnet lists or configuration lists from different sources.

---

## 9.9 `flatten()` Function

`flatten()` recursively removes directly nested list structure until the result is a single-level list. It is useful when nested configuration data must be transformed into a flat collection for resource iteration.

### 💻 Code

```hcl
locals {
  nested_subnets = [
    ["subnet-a", "subnet-b"],
    ["subnet-c", "subnet-d"]
  ]

  all_subnets = flatten(local.nested_subnets)
}
```

### 📤 Output

```text
all_subnets = [
  "subnet-a",
  "subnet-b",
  "subnet-c",
  "subnet-d"
]
```

### 🎯 Use Case

Flatten nested subnet, application, or environment collections before creating resources.

---

# 🎯 10. Indexing and Element Access

Indexing expressions access elements in lists, tuples, and other indexable values. Terraform uses zero-based indexing, meaning the first element has index `0`, the second has index `1`, and so on.

## 10.1 List Indexing — `[index]`

List indexing retrieves an element at a specified zero-based numeric position. The requested index must exist; otherwise, Terraform reports an error rather than automatically returning an empty value.

### 💻 Code

```hcl
locals {
  regions = [
    "ap-south-1",
    "us-east-1",
    "eu-west-1"
  ]

  first_region = local.regions[0]
}
```

### 📤 Output

```text
first_region = "ap-south-1"
```

### 🎯 Use Case

Retrieve a specific item from an ordered list.

---

## 10.2 Map Indexing — `["key"]`

Map indexing retrieves the value associated with a specific string key. The key must exist unless the configuration uses a safe lookup pattern or another expression that handles missing keys.

### 💻 Code

```hcl
locals {
  instance_types = {
    dev  = "t3.micro"
    prod = "t3.large"
  }

  production_type = local.instance_types["prod"]
}
```

### 📤 Output

```text
production_type = "t3.large"
```

### 🎯 Use Case

Retrieve environment-specific values from a map.

---

## 10.3 `element()` Function

`element()` retrieves a list element at a given zero-based index, using cyclic index behavior when the index exceeds the list length. Empty lists cannot provide an element, so validate the input when necessary.

### 💻 Code

```hcl
locals {
  zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  selected_zone = element(local.zones, 1)
}
```

### 📤 Output

```text
selected_zone = "ap-south-1b"
```

### 🎯 Use Case

Select an element by index when the function's cyclic behavior is specifically desired.

> ⚠️ Direct indexing is often clearer when cyclic behavior is unnecessary.

---

## 10.4 `lookup()` Function

`lookup()` retrieves a map value using a key and returns a specified default when the key does not exist. It helps avoid missing-key errors when a fallback value is appropriate.

### 💻 Code

```hcl
locals {
  instance_types = {
    dev  = "t3.micro"
    prod = "t3.large"
  }

  staging_type = lookup(
    local.instance_types,
    "staging",
    "t3.small"
  )
}
```

### 📤 Output

```text
staging_type = "t3.small"
```

### 🎯 Use Case

Retrieve optional map values with a fallback.

---

## 10.5 `try()` Function

`try()` evaluates its arguments in order and returns the first expression that does not produce a dynamic error. It is useful for handling uncertain data structures and providing controlled fallbacks for missing attributes.

### 💻 Code

```hcl
locals {
  settings = {
    environment = "dev"
  }

  instance_type = try(
    local.settings.instance_type,
    "t3.micro"
  )
}
```

### 📤 Output

```text
instance_type = "t3.micro"
```

### 🎯 Use Case

Safely access optional attributes in complex configuration data.

> ⚠️ `try()` should not be used to conceal unrelated configuration errors. Keep its arguments focused on expressions where failure is genuinely expected.

---

# 🏷️ 11. Attribute Access Expressions

Attribute access retrieves a named value from an object or from an attribute-bearing Terraform reference. It is commonly used to access resource IDs, object properties, data source attributes, and module outputs.

## 11.1 Dot Notation — `.attribute`

Dot notation accesses a named attribute of an object or resource reference. It is the most readable form when an attribute name is known directly and does not need to be calculated dynamically.

### 💻 Code

```hcl
locals {
  server = {
    name = "web"
    port = 8080
  }

  server_name = local.server.name
}
```

### 📤 Output

```text
server_name = "web"
```

### 🎯 Use Case

Access object fields, resource IDs, and module outputs.

---

## 11.2 Bracket Attribute Access — `["attribute"]`

Bracket notation accesses an attribute using a string key. It is useful when the key is stored in another expression or when the configuration benefits from consistent key-based access.

### 💻 Code

```hcl
locals {
  server = {
    name = "web"
    port = 8080
  }

  server_name = local.server["name"]
}
```

### 📤 Output

```text
server_name = "web"
```

### 🎯 Use Case

Access an object attribute using a string key.

---

## 11.3 Nested Attribute Access

Nested attribute access chains multiple attribute references to retrieve a deeply nested value. Each intermediate attribute must exist and have a compatible structure for Terraform to evaluate the complete expression successfully.

### 💻 Code

```hcl
locals {
  application = {
    network = {
      subnet = {
        cidr = "10.0.1.0/24"
      }
    }
  }

  subnet_cidr = local.application.network.subnet.cidr
}
```

### 📤 Output

```text
subnet_cidr = "10.0.1.0/24"
```

### 🎯 Use Case

Read deeply nested application, networking, or environment configuration.

---

# 🔁 12. For Expressions

A for expression iterates over a collection and constructs a new tuple, list, object, or map. It can transform values, select attributes, filter elements, and build configuration structures from existing data.

## 12.1 List Transformation

A list-producing for expression processes each element of an input collection and returns an ordered tuple of calculated results. This is useful when each source element must be transformed independently.

### 💻 Code

```hcl
locals {
  names = ["web", "api", "db"]

  prefixed_names = [
    for name in local.names : "app-${name}"
  ]
}
```

### 📤 Output

```text
prefixed_names = [
  "app-web",
  "app-api",
  "app-db"
]
```

### 🎯 Use Case

Add prefixes to names or transform values into a new list.

---

## 12.2 Filtering with `if`

An `if` clause inside a for expression includes only elements that satisfy its Boolean condition. Filtering is useful when a collection contains multiple values but only a selected subset should appear in the result.

### 💻 Code

```hcl
locals {
  environments = [
    "dev",
    "staging",
    "prod"
  ]

  production_only = [
    for environment in local.environments : environment
    if environment == "prod"
  ]
}
```

### 📤 Output

```text
production_only = [
  "prod"
]
```

### 🎯 Use Case

Select only production environments or filter resources according to a property.

---

## 12.3 Object or Map Transformation

An object-producing for expression generates key-value pairs from an input collection. Each iteration calculates a result key and value, making this pattern useful for constructing maps that drive resource creation.

### 💻 Code

```hcl
locals {
  environments = [
    "dev",
    "staging",
    "prod"
  ]

  environment_map = {
    for environment in local.environments :
    environment => upper(environment)
  }
}
```

### 📤 Output

```text
environment_map = {
  dev     = "DEV"
  staging = "STAGING"
  prod    = "PROD"
}
```

### 🎯 Use Case

Build maps for environment-specific settings or resource configuration.

---

## 12.4 Key-Value Iteration

A for expression can iterate over both the key and value of a map. This enables transformation based on existing map keys while preserving or modifying the corresponding values.

### 💻 Code

```hcl
locals {
  instance_types = {
    dev  = "t3.micro"
    prod = "t3.large"
  }

  prefixed_types = {
    for environment, instance_type in local.instance_types :
    environment => "aws-${instance_type}"
  }
}
```

### 📤 Output

```text
prefixed_types = {
  dev  = "aws-t3.micro"
  prod = "aws-t3.large"
}
```

### 🎯 Use Case

Transform each key-value pair while preserving its key.

---

## 12.5 Filtering a Map

A filtered map-producing for expression includes only the entries that satisfy a specified condition. This allows configuration maps to be reduced dynamically according to the values or keys associated with each entry.

### 💻 Code

```hcl
locals {
  instance_counts = {
    dev     = 1
    staging = 2
    prod    = 5
  }

  large_environments = {
    for environment, count in local.instance_counts :
    environment => count
    if count >= 2
  }
}
```

### 📤 Output

```text
large_environments = {
  staging = 2
  prod    = 5
}
```

### 🎯 Use Case

Filter environments, configurations, or resources according to numeric thresholds.

---

## 12.6 Grouping Mode — `...`

The grouping operator `...` in an object-producing for expression groups values that produce the same key into lists. Without grouping mode, duplicate result keys normally cause an error.

### 💻 Code

```hcl
locals {
  users = [
    {
      name = "Amit"
      team = "DevOps"
    },
    {
      name = "Priya"
      team = "Cloud"
    },
    {
      name = "Rahul"
      team = "DevOps"
    }
  ]

  users_by_team = {
    for user in local.users :
    user.team => user.name...
  }
}
```

### 📤 Output

```text
users_by_team = {
  Cloud = [
    "Priya"
  ]
  DevOps = [
    "Amit",
    "Rahul"
  ]
}
```

### 🎯 Use Case

Group users by team, resources by environment, or values by category.

---

# 🌟 13. Splat Expressions

Splat expressions retrieve an attribute or element from every item in a collection. They provide a compact alternative to certain for expressions, particularly when the same attribute must be extracted from every resource instance.

## 13.1 Full Splat — `[*]`

The full splat expression applies an attribute or index access operation to every element of a collection and returns the corresponding results. It is useful when extracting the same property from multiple resources.

### 💻 Code

```hcl
variable "servers" {
  default = [
    {
      name = "web"
      port = 8080
    },
    {
      name = "api"
      port = 9000
    }
  ]
}

locals {
  server_names = var.servers[*].name
}
```

### 📤 Output

```text
server_names = [
  "web",
  "api"
]
```

### 🎯 Use Case

Extract names, IDs, or other attributes from a collection of objects.

---

## 13.2 Attribute Splat — `[*].attribute`

An attribute splat accesses a named attribute on every element of a collection and returns those values as a sequence. It is especially useful when resources are created with `count` and their attributes need to be collected.

### 💻 Code

```hcl
locals {
  server_names = var.servers[*].name
}
```

### 📤 Output

```text
server_names = [
  "web",
  "api"
]
```

### 🎯 Use Case

Collect one attribute from multiple objects or resource instances.

---

## 13.3 Legacy Splat — `.*`

The legacy splat syntax uses `.*` to project an attribute from a collection, but its traversal behavior differs from the full splat syntax. New configurations should generally prefer `[*]` for clearer and more consistent behavior.

### 💻 Code

```hcl
# Legacy syntax
# Example shape: var.servers.*.name

# Preferred modern syntax
locals {
  server_names = var.servers[*].name
}
```

### 📤 Output

```text
server_names = [
  "web",
  "api"
]
```

### 🎯 Use Case

Understand older Terraform configurations and migrate legacy splat expressions to modern syntax.

---

## 13.4 Splat Expressions with `count`

When a resource uses `count`, Terraform exposes its instances as a collection. A splat expression can retrieve a particular attribute from all instances without manually writing an index for each resource.

### 💻 Code

```hcl
resource "aws_instance" "web" {
  count         = 2
  ami           = var.ami_id
  instance_type = "t3.micro"
}

output "instance_ids" {
  value = aws_instance.web[*].id
}
```

### 📤 Expected Output

```text
instance_ids = [
  "i-xxxxxxxxxxxxxxxxx",
  "i-yyyyyyyyyyyyyyyyy"
]
```

The actual IDs are assigned by AWS.

### 🎯 Use Case

Collect IDs or public IP addresses from resources created with `count`.

---

# 🛠️ 14. Function Calls and Built-in Functions

Terraform functions accept arguments, perform a defined operation, and return a value. They help normalize strings, transform collections, handle optional values, calculate results, and encode or decode structured data.

> 📌 Terraform's function library is extensive. This section covers important functions commonly used in practical infrastructure configurations.

## 14.1 `length()`

`length()` returns the number of elements in a collection or the number of characters in a string. It is commonly used to determine collection size and validate whether configuration data contains enough entries.

### 💻 Code

```hcl
locals {
  total_subnets = length([
    "subnet-a",
    "subnet-b",
    "subnet-c"
  ])
}
```

### 📤 Output

```text
total_subnets = 3
```

### 🎯 Use Case

Count subnets, environments, names, or other collection elements.

---

## 14.2 `contains()`

`contains()` checks whether a list or set includes a specified value. It returns a Boolean result and is useful for validating membership or enabling behavior when a particular item exists.

### 💻 Code

```hcl
locals {
  environments = ["dev", "staging", "prod"]

  has_production = contains(
    local.environments,
    "prod"
  )
}
```

### 📤 Output

```text
has_production = true
```

### 🎯 Use Case

Check whether a supported environment or feature exists in a collection.

---

## 14.3 `distinct()`

`distinct()` removes duplicate values from a list while preserving the order of the first occurrence of each value. It is useful for cleaning configuration collections that may contain repeated entries.

### 💻 Code

```hcl
locals {
  unique_names = distinct([
    "web",
    "api",
    "web",
    "db"
  ])
}
```

### 📤 Output

```text
unique_names = [
  "web",
  "api",
  "db"
]
```

### 🎯 Use Case

Remove duplicate names or repeated values from a list.

---

## 14.4 `sort()`

`sort()` sorts a list of strings into ascending lexical order. It helps create deterministic sequences for readable outputs and operations where predictable string ordering is useful.

### 💻 Code

```hcl
locals {
  sorted_regions = sort([
    "us-east-1",
    "ap-south-1",
    "eu-west-1"
  ])
}
```

### 📤 Output

```text
sorted_regions = [
  "ap-south-1",
  "eu-west-1",
  "us-east-1"
]
```

### 🎯 Use Case

Sort names, identifiers, or other strings into a predictable order.

---

## 14.5 `reverse()`

`reverse()` reverses the order of elements in a list. It is useful when a collection needs to be processed or displayed in the opposite sequence from its original arrangement.

### 💻 Code

```hcl
locals {
  reversed = reverse([
    "first",
    "second",
    "third"
  ])
}
```

### 📤 Output

```text
reversed = [
  "third",
  "second",
  "first"
]
```

### 🎯 Use Case

Reverse an ordered list of configuration values.

---

## 14.6 `keys()`

`keys()` returns the keys of a map or object as a list of strings. Terraform orders map keys lexically in the resulting list, allowing configurations to enumerate or process the names of entries.

### 💻 Code

```hcl
locals {
  instance_types = {
    dev  = "t3.micro"
    prod = "t3.large"
    test = "t3.small"
  }

  environments = keys(local.instance_types)
}
```

### 📤 Output

```text
environments = [
  "dev",
  "prod",
  "test"
]
```

### 🎯 Use Case

Retrieve environment names or other keys from a map.

---

## 14.7 `values()`

`values()` returns the values associated with a map or object as a list ordered according to the lexical ordering of the corresponding keys. It is useful when the values are needed independently of their original keys.

### 💻 Code

```hcl
locals {
  instance_types = {
    dev  = "t3.micro"
    prod = "t3.large"
    test = "t3.small"
  }

  all_types = values(local.instance_types)
}
```

### 📤 Output

```text
all_types = [
  "t3.micro",
  "t3.large",
  "t3.small"
]
```

### 🎯 Use Case

Extract map values for further processing.

---

## 14.8 `zipmap()`

`zipmap()` creates a map by pairing corresponding elements from a list of keys and a list of values. The input lists must have matching lengths so every key can be paired with a value.

### 💻 Code

```hcl
locals {
  environments = ["dev", "prod"]
  types        = ["t3.micro", "t3.large"]

  instance_map = zipmap(
    local.environments,
    local.types
  )
}
```

### 📤 Output

```text
instance_map = {
  dev  = "t3.micro"
  prod = "t3.large"
}
```

### 🎯 Use Case

Build environment maps from two corresponding lists.

---

## 14.9 `range()`

`range()` generates a sequence of integers within a specified boundary. Depending on its arguments, it can start at zero or a chosen starting point and stop before the specified upper boundary.

### 💻 Code

```hcl
locals {
  numbers = range(1, 5)
}
```

### 📤 Output

```text
numbers = [
  1,
  2,
  3,
  4
]
```

### 🎯 Use Case

Generate numeric sequences for indexing, numbering, or calculated configuration.

---

## 14.10 `min()`

`min()` returns the smallest numeric argument supplied to the function. It helps enforce lower-value selection rules when several numeric candidates are available.

### 💻 Code

```hcl
locals {
  minimum_value = min(10, 5, 20)
}
```

### 📤 Output

```text
minimum_value = 5
```

### 🎯 Use Case

Select the smallest numeric value among several candidates.

---

## 14.11 `max()`

`max()` returns the largest numeric argument supplied to the function. It is useful for determining a maximum value or choosing the greatest capacity among several numeric candidates.

### 💻 Code

```hcl
locals {
  maximum_value = max(10, 5, 20)
}
```

### 📤 Output

```text
maximum_value = 20
```

### 🎯 Use Case

Select the largest numeric value among several candidates.

---

## 14.12 `abs()`

`abs()` returns the absolute value of a number, removing its negative sign when present. It is useful when calculations require a non-negative magnitude regardless of the original sign.

### 💻 Code

```hcl
locals {
  absolute_value = abs(-25)
}
```

### 📤 Output

```text
absolute_value = 25
```

### 🎯 Use Case

Convert a numeric difference into a non-negative magnitude.

---

## 14.13 `ceil()`

`ceil()` rounds a numeric value upward to the smallest whole number that is greater than or equal to it. It is useful when fractional calculations must produce a whole-number quantity without underestimating requirements.

### 💻 Code

```hcl
locals {
  rounded_up = ceil(4.2)
}
```

### 📤 Output

```text
rounded_up = 5
```

### 🎯 Use Case

Round up calculated quantities when a partial unit still requires a whole unit.

---

## 14.14 `floor()`

`floor()` rounds a numeric value downward to the greatest whole number that is less than or equal to it. It is useful when a calculation requires the whole-number portion without rounding upward.

### 💻 Code

```hcl
locals {
  rounded_down = floor(4.9)
}
```

### 📤 Output

```text
rounded_down = 4
```

### 🎯 Use Case

Calculate the whole-number portion of a numeric result.

---

## 14.15 `tostring()`

`tostring()` converts a compatible value into a string representation. It is useful when building text from numeric or Boolean values or when a configuration argument explicitly requires a string.

### 💻 Code

```hcl
locals {
  instance_count_text = tostring(3)
}
```

### 📤 Output

```text
instance_count_text = "3"
```

### 🎯 Use Case

Convert a number to text before combining it with other strings.

---

## 14.16 `tonumber()`

`tonumber()` converts a valid numeric string into a number. It is useful when numeric input arrives as text, although invalid numeric strings cause an error unless handled through an appropriate fallback pattern.

### 💻 Code

```hcl
locals {
  port_number = tonumber("8080")
}
```

### 📤 Output

```text
port_number = 8080
```

### 🎯 Use Case

Convert a numeric string into a number for calculations and comparisons.

---

## 14.17 `tobool()`

`tobool()` converts a compatible value into a Boolean. It is useful when a configuration receives Boolean-like text and needs a true or false value for conditional expressions or feature settings.

### 💻 Code

```hcl
locals {
  monitoring_enabled = tobool("true")
}
```

### 📤 Output

```text
monitoring_enabled = true
```

### 🎯 Use Case

Convert compatible Boolean text into a Boolean value.

---

## 14.18 `tolist()`

`tolist()` converts a compatible collection into a list. It is useful when a value must have list semantics, particularly when normalizing input collections or ensuring compatible collection types in an expression.

### 💻 Code

```hcl
locals {
  names = tolist(["web", "api"])
}
```

### 📤 Output

```text
names = [
  "web",
  "api"
]
```

### 🎯 Use Case

Normalize compatible collection values to list form.

---

## 14.19 `toset()`

`toset()` converts a compatible collection into a set, removing duplicate elements and discarding any guarantee of positional ordering. It is useful when unique values are required for collection operations or resource iteration.

### 💻 Code

```hcl
locals {
  unique_names = toset([
    "web",
    "api",
    "web"
  ])
}
```

### 📤 Output

```text
unique_names = toset([
  "api",
  "web"
])
```

The order shown is illustrative; sets do not guarantee list-style ordering.

### 🎯 Use Case

Create a collection of unique values.

---

## 14.20 `tomap()`

`tomap()` converts a compatible mapping value into a map with a consistent value type. It is useful when a map must be explicitly typed or normalized for use by another expression or module.

### 💻 Code

```hcl
locals {
  environment_map = tomap({
    dev  = "development"
    prod = "production"
  })
}
```

### 📤 Output

```text
environment_map = {
  dev  = "development"
  prod = "production"
}
```

### 🎯 Use Case

Normalize a compatible object or mapping into map form.

---

## 14.21 `jsonencode()`

`jsonencode()` converts a Terraform value into a JSON-formatted string. It is useful for generating JSON policies, application configuration, and payloads that must be supplied as text to another system.

### 💻 Code

```hcl
locals {
  configuration_json = jsonencode({
    environment = "dev"
    enabled     = true
  })
}
```

### 📤 Output

```text
"{\"enabled\":true,\"environment\":\"dev\"}"
```

JSON object keys may appear in a normalized order. The exact display representation depends on how the string is rendered.

### 🎯 Use Case

Generate JSON configuration or policy documents.

---

## 14.22 `jsondecode()`

`jsondecode()` parses a valid JSON string and converts it into a corresponding Terraform value. Objects become structural values, arrays become sequences, and JSON primitive values become their Terraform equivalents.

### 💻 Code

```hcl
locals {
  configuration = jsondecode(
    "{\"environment\":\"dev\",\"enabled\":true}"
  )
}
```

### 📤 Output

```text
local.configuration = {
  environment = "dev"
  enabled     = true
}
```

### 🎯 Use Case

Read JSON-formatted configuration from a string.

---

## 14.23 `file()`

`file()` reads an existing UTF-8 text file from the filesystem and returns its contents as a string. The file must exist when Terraform evaluates the function; it does not read files created later during the same apply.

### 💻 Code

Suppose `message.txt` contains:

```text
Hello Terraform
```

Then use:

```hcl
locals {
  message = file("${path.module}/message.txt")
}
```

### 📤 Output

```text
local.message = "Hello Terraform\n"
```

The trailing newline appears if the file contains one.

### 🎯 Use Case

Read scripts, certificates in text format, or configuration files already present on disk.

---

## 14.24 `templatefile()`

`templatefile()` reads a template file and renders it using the variables supplied in a mapping. It supports template interpolation and directives, making it useful for reusable scripts and generated configuration files.

### 💻 Code

Create `config.tftpl`:

```text
Environment: ${environment}
Region: ${region}
```

Terraform configuration:

```hcl
locals {
  rendered_config = templatefile(
    "${path.module}/config.tftpl",
    {
      environment = "dev"
      region      = "ap-south-1"
    }
  )
}
```

### 📤 Output

```text
Environment: dev
Region: ap-south-1
```

### 🎯 Use Case

Generate environment-specific scripts or text configuration from reusable templates.

---

# 🔄 15. Type Conversion Expressions

Type conversion expressions change a value's type or normalize its structure. Terraform often infers types automatically, but explicit conversion functions help make complex configurations predictable and resolve compatibility problems.

## 15.1 Implicit Type Conversion

Implicit conversion occurs when Terraform can automatically convert a compatible value to the type required by an expression or argument. Although convenient, relying on it excessively can obscure the intended type of a configuration value.

### 💻 Code

```hcl
variable "instance_count" {
  type    = number
  default = 3
}

locals {
  count_text = "${var.instance_count}"
}
```

### 📤 Output

```text
count_text = "3"
```

### 🎯 Use Case

Understand automatic conversions when values are combined with strings or passed to typed arguments.

---

## 15.2 Explicit Type Conversion

Explicit conversion calls a type-conversion function such as `tostring()`, `tonumber()`, `tobool()`, `tolist()`, or `toset()`. This makes the intended type clearer and can prevent inconsistent results in complex expressions.

### 💻 Code

```hcl
locals {
  port_text = "8080"
  port      = tonumber(local.port_text)
}
```

### 📤 Output

```text
local.port = 8080
```

### 🎯 Use Case

Normalize input values before performing calculations or passing them to resources.

---

## 15.3 `try()` for Type and Attribute Handling

`try()` returns the first argument that evaluates without a dynamic error. It can help normalize optional attributes before conversion, but it should not be treated as a general replacement for proper variable validation.

### 💻 Code

```hcl
locals {
  raw_settings = {
    port = "8080"
  }

  port = try(
    tonumber(local.raw_settings.port),
    80
  )
}
```

### 📤 Output

```text
local.port = 8080
```

### 🎯 Use Case

Convert optional configuration values and provide a fallback when the conversion expression fails.

---

## 15.4 `can()` Function

`can()` evaluates whether an expression can be evaluated without producing an error and returns a Boolean result. It is particularly useful in validation conditions that must check whether a value has an expected form.

### 💻 Code

```hcl
locals {
  valid_number = can(tonumber("8080"))
  invalid_number = can(tonumber("hello"))
}
```

### 📤 Output

```text
local.valid_number   = true
local.invalid_number = false
```

### 🎯 Use Case

Check whether a conversion or attribute access is valid without using the result directly.

---

## 15.5 `type()` Considerations

Terraform does not provide a general-purpose `type()` function for arbitrary runtime type inspection in ordinary configuration expressions. Use declared variable constraints, conversion functions, and validation rules to express expected types explicitly.

### 💡 Example

```hcl
variable "instance_count" {
  type = number

  validation {
    condition     = var.instance_count >= 1
    error_message = "Instance count must be at least 1."
  }
}
```

### 🎯 Use Case

Declare and validate the type and acceptable range of configuration inputs.

---

# 🧩 16. Parentheses and Expression Grouping

Parentheses group parts of an expression and control evaluation order. They improve readability and help ensure that mathematical operations, nested conditionals, and logical expressions are evaluated in the intended structure.

## 16.1 Arithmetic Grouping — `()`

Parentheses explicitly group arithmetic subexpressions so the grouped operation is evaluated according to the intended mathematical structure. They also make complex expressions easier for readers to understand and maintain.

### 💻 Code

```hcl
locals {
  result = (10 + 5) * 2
}
```

### 📤 Output

```text
result = 30
```

### 🎯 Use Case

Make calculation order explicit.

---

## 16.2 Logical Grouping

Parentheses group logical conditions to clarify how multiple comparisons are combined. Terraform follows defined operator precedence, but explicit grouping reduces ambiguity and helps prevent mistakes when a condition becomes complex.

### 💻 Code

```hcl
locals {
  deployment_allowed = (
    true && true
  ) || false
}
```

### 📤 Output

```text
deployment_allowed = true
```

### 🎯 Use Case

Clarify compound deployment conditions.

---

## 16.3 Conditional Grouping

Parentheses can group nested conditional expressions to make branch boundaries clearer. This is particularly helpful when a condition selects between multiple values and one branch contains another conditional expression.

### 💻 Code

```hcl
locals {
  environment    = "staging"
  instance_type  = local.environment == "prod" ? "t3.large" : (
    local.environment == "staging" ? "t3.medium" : "t3.micro"
  )
}
```

### 📤 Output

```text
instance_type = "t3.medium"
```

### 🎯 Use Case

Improve readability in multi-environment configuration logic.

---

# 🏗️ 17. Practical Usage: `count` and `for_each`

Terraform's `count` and `for_each` meta-arguments use expressions to control how many resource or module instances Terraform manages. Both support dynamic infrastructure creation, but they identify and track instances differently.

## 17.1 `count`

The `count` meta-argument creates a specified number of resource or module instances using a non-negative whole-number value. Each instance is identified by a numeric index, making `count` suitable for simple repeated resources.

### 💻 Code

```hcl
variable "instance_count" {
  type    = number
  default = 2
}

resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = "t3.micro"
}
```

### 📤 Expected Behavior

```text
instance_count = 2

aws_instance.web[0]
aws_instance.web[1]
```

### 🎯 Use Case

Create a fixed number of similar instances.

### ⚠️ Important Consideration

Changing the number or ordering of count-driven instances can shift numeric indexes. When instances represent distinct named entities, `for_each` is often a better choice.

---

## 17.2 `for_each`

The `for_each` meta-argument creates one resource or module instance for every key in a map or every distinct member of a set of strings. Each instance is identified by its key rather than by a numeric position.

### 💻 Code

```hcl
variable "environments" {
  type = set(string)

  default = [
    "dev",
    "prod"
  ]
}

resource "aws_s3_bucket" "environment" {
  for_each = var.environments

  bucket = "example-${each.key}-bucket-12345"
}
```

### 📤 Expected Behavior

```text
aws_s3_bucket.environment["dev"]
aws_s3_bucket.environment["prod"]
```

The example bucket names are illustrative and must satisfy S3 naming requirements and global uniqueness.

### 🎯 Use Case

Create named resources for different environments or applications.

---

## 17.3 `each.key`

`each.key` identifies the current key during a resource or module block's `for_each` iteration. When iterating over a map, it returns the map key; when iterating over a set of strings, it returns the current set member.

### 💻 Code

```hcl
resource "aws_s3_bucket" "environment" {
  for_each = toset(["dev", "prod"])

  bucket = "example-${each.key}-bucket-12345"
}
```

### 📤 Example

```text
each.key = "dev"
```

The value differs for each instance.

### 🎯 Use Case

Generate instance-specific names from the current iteration key.

---

## 17.4 `each.value`

`each.value` retrieves the value associated with the current `for_each` key. When the input is a map, the value can contain structured configuration; when the input is a set, the value is the current set member.

### 💻 Code

```hcl
locals {
  instance_types = {
    dev  = "t3.micro"
    prod = "t3.large"
  }
}

resource "aws_instance" "environment" {
  for_each      = local.instance_types
  ami           = var.ami_id
  instance_type = each.value
}
```

### 📤 Expected Behavior

```text
aws_instance.environment["dev"].instance_type  = "t3.micro"
aws_instance.environment["prod"].instance_type = "t3.large"
```

### 🎯 Use Case

Assign different settings to named resource instances.

---

## 17.5 `count` vs `for_each`

Both meta-arguments create multiple instances, but they differ in how those instances are addressed. Choosing the correct mechanism helps maintain stable resource identities when configuration collections change.

| Feature | `count` | `for_each` |
|---|---|---|
| Input | Non-negative integer | Map or set of strings |
| Instance address | Numeric index | Map key or set member |
| Best for | Repeated, interchangeable instances | Distinct, named instances |
| Example | `resource.example[0]` | `resource.example["prod"]` |
| Main concern | Index shifts when ordering or count changes | Changing keys can change instance addresses |

### 🎯 Recommendation

Use `count` when the instances are interchangeable and their numeric positions do not carry important meaning.

Use `for_each` when each instance represents a named environment, application, user, or other distinct entity.

---

# 🌍 18. Real-World Terraform Example

This example combines variables, local values, conditional expressions, collection transformations, and resource creation in one small AWS configuration.

## 📁 Project Structure

```text
terraform-expressions/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## 18.1 `variables.tf`

```hcl
variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition = contains(
      ["dev", "staging", "prod"],
      var.environment
    )

    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "ami_id" {
  description = "A valid, region-compatible AMI ID."
  type        = string
}

variable "create_bucket" {
  description = "Whether to create the S3 bucket."
  type        = bool
  default     = true
}
```

### 🧠 Expressions Used

- `var.environment` — reads an input variable.
- `contains()` — checks whether the environment belongs to an approved list.
- `var.ami_id` — supplies the AMI identifier.
- `var.create_bucket` — controls optional resource creation.

---

## 18.2 `main.tf`

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  project_name = "payment"

  instance_type = (
    var.environment == "prod"
    ? "t3.large"
    : "t3.micro"
  )

  resource_name = join("-", [
    local.project_name,
    var.environment
  ])

  common_tags = {
    Project     = local.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  enabled_features = {
    monitoring = true
    backups    = var.environment == "prod"
  }
}

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = local.instance_type

  tags = merge(
    local.common_tags,
    {
      Name = local.resource_name
    }
  )
}

resource "aws_s3_bucket" "logs" {
  count = var.create_bucket ? 1 : 0

  bucket = "${local.resource_name}-logs-12345"

  tags = local.common_tags
}
```

### 📌 Important Notes

- Replace the example AMI input with an AMI that is valid for the selected AWS region and instance architecture.
- Ensure the S3 bucket name is globally unique and complies with AWS requirements.
- The example uses AWS provider version 5.x. Review provider compatibility when adapting it to another version.
- Creating an EC2 instance or S3 bucket can incur AWS charges.

---

## 18.3 `outputs.tf`

```hcl
output "environment" {
  description = "Selected deployment environment."
  value       = var.environment
}

output "instance_type" {
  description = "Selected EC2 instance type."
  value       = local.instance_type
}

output "instance_id" {
  description = "Created EC2 instance ID."
  value       = aws_instance.app.id
}

output "bucket_names" {
  description = "Created log bucket names."
  value       = aws_s3_bucket.logs[*].bucket
}

output "enabled_features" {
  description = "Feature configuration."
  value       = local.enabled_features
}
```

### 📤 Illustrative Output

Actual AWS-generated identifiers will vary.

```text
environment = "dev"
instance_type = "t3.micro"
instance_id = "i-xxxxxxxxxxxxxxxxx"

bucket_names = [
  "payment-dev-logs-12345"
]

enabled_features = {
  monitoring = true
  backups    = false
}
```

---

## 18.4 🚀 Run Terraform

Initialize the working directory:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

Review the planned infrastructure changes:

```bash
terraform plan -var="ami_id=ami-0123456789abcdef0"
```

Apply the configuration after reviewing the plan:

```bash
terraform apply -var="ami_id=ami-0123456789abcdef0"
```

Display the outputs:

```bash
terraform output
```

Destroy the resources when they are no longer needed:

```bash
terraform destroy -var="ami_id=ami-0123456789abcdef0"
```

> ⚠️ Use an appropriate AMI ID for your AWS region. Review the plan carefully before applying or destroying infrastructure.

---

# 📖 19. Quick Function Reference

The following table summarizes commonly used functions and the tasks they perform.

| Function | Purpose | Example |
|---|---|---|
| `length()` | Count characters or collection elements | `length(["a", "b"])` |
| `contains()` | Check collection membership | `contains(["dev", "prod"], "prod")` |
| `alltrue()` | Require every Boolean value to be true | `alltrue([true, true])` |
| `anytrue()` | Check whether any Boolean value is true | `anytrue([false, true])` |
| `join()` | Combine strings using a separator | `join("-", ["web", "dev"])` |
| `format()` | Create formatted text | `format("%s-%02d", "web", 1)` |
| `upper()` | Convert text to uppercase | `upper("dev")` |
| `lower()` | Convert text to lowercase | `lower("PROD")` |
| `title()` | Convert text to title case | `title("cloud team")` |
| `trimspace()` | Remove surrounding whitespace | `trimspace(" dev ")` |
| `replace()` | Replace matching text | `replace("a_b", "_", "-")` |
| `merge()` | Combine maps or objects | `merge({a = 1}, {b = 2})` |
| `concat()` | Combine sequences | `concat(["a"], ["b"])` |
| `flatten()` | Flatten nested lists | `flatten([["a"], ["b"]])` |
| `distinct()` | Remove duplicate list elements | `distinct(["a", "a", "b"])` |
| `sort()` | Sort strings | `sort(["prod", "dev"])` |
| `reverse()` | Reverse a list | `reverse(["a", "b"])` |
| `keys()` | Retrieve map keys | `keys({dev = "small"})` |
| `values()` | Retrieve map values | `values({dev = "small"})` |
| `zipmap()` | Build a map from keys and values | `zipmap(["dev"], ["small"])` |
| `range()` | Generate integer sequences | `range(1, 4)` |
| `min()` | Return the smallest number | `min(1, 2, 3)` |
| `max()` | Return the largest number | `max(1, 2, 3)` |
| `abs()` | Return absolute numeric value | `abs(-5)` |
| `ceil()` | Round upward | `ceil(4.2)` |
| `floor()` | Round downward | `floor(4.9)` |
| `lookup()` | Read a map value with fallback | `lookup({dev = "small"}, "prod", "large")` |
| `element()` | Retrieve a list element with cyclic indexing | `element(["a", "b"], 1)` |
| `try()` | Return the first non-error expression | `try(local.settings.name, "default")` |
| `can()` | Test whether an expression can evaluate | `can(tonumber("123"))` |
| `tostring()` | Convert a value to text | `tostring(123)` |
| `tonumber()` | Convert a compatible value to a number | `tonumber("123")` |
| `tobool()` | Convert a compatible value to Boolean | `tobool("true")` |
| `tolist()` | Convert a compatible collection to a list | `tolist(["a", "b"])` |
| `toset()` | Convert a compatible collection to a set | `toset(["a", "a"])` |
| `tomap()` | Convert a compatible mapping to a map | `tomap({dev = "small"})` |
| `jsonencode()` | Encode a value as JSON text | `jsonencode({enabled = true})` |
| `jsondecode()` | Parse JSON text into a Terraform value | `jsondecode("{\"enabled\":true}")` |
| `file()` | Read an existing text file | `file("${path.module}/message.txt")` |
| `templatefile()` | Render a file template | `templatefile("${path.module}/config.tftpl", {env = "dev"})` |

---

# ⚠️ 20. Common Mistakes

## ❌ Mistake 1: Using `=` Instead of `==` for Comparison

Inside an expression, `==` compares values. The `=` symbol assigns an argument value in a block or defines a key-value pair in an object.

```hcl
locals {
  correct   = var.environment == "prod"
  incorrect = var.environment = "prod"
}
```

The `incorrect` expression is invalid in this context.

---

## ❌ Mistake 2: Using the Wrong Collection Index

Terraform lists use zero-based indexes, so the first element is at index `0`. Requesting an index beyond the collection's valid range produces an error.

```hcl
locals {
  regions = ["ap-south-1", "us-east-1"]

  first_region = local.regions[0]
}
```

Expected:

```text
first_region = "ap-south-1"
```

---

## ❌ Mistake 3: Treating `null` as an Empty String

`null` represents an absent value, while `""` represents a string containing zero characters. They have different meanings and can behave differently when passed to provider arguments.

```hcl
locals {
  absent_value = null
  empty_text   = ""
}
```

---

## ❌ Mistake 4: Using `count` with Unstable Ordering

Using a list index as the identity of a distinct resource can cause Terraform to associate an existing instance with a different logical item after the list changes.

**Better approach:** Use `for_each` with stable keys when resources represent distinct entities.

---

## ❌ Mistake 5: Forgetting That `for_each` Needs Suitable Input

Resource-level `for_each` expects a map or a set of strings. It cannot directly iterate over an ordinary list of objects without transforming that collection into an appropriate map or set.

```hcl
locals {
  applications = {
    web = {
      port = 8080
    }

    api = {
      port = 9000
    }
  }
}
```

The map keys can identify the resource instances.

---

## ❌ Mistake 6: Assuming Sets Preserve List Order

Sets contain unique elements and do not promise the same positional ordering as lists. If ordering matters, explicitly use a list and apply a suitable ordering operation.

```hcl
locals {
  unique_names = toset(["web", "api", "web"])
  ordered_names = sort(tolist(local.unique_names))
}
```

---

## ❌ Mistake 7: Using `try()` to Hide Every Error

`try()` should handle anticipated dynamic evaluation errors rather than silently mask unrelated mistakes. Keep the expression narrow and use validation for required inputs and business rules.

```hcl
locals {
  optional_name = try(local.settings.name, "default")
}
```

---

# ✅ 21. Best Practices

- 🧱 **Use variables:** Make environment-specific and reusable values configurable instead of hardcoding them.
- 🏷️ **Use locals:** Centralize repeated calculations, common tags, and naming conventions.
- 🔀 **Use conditionals carefully:** Keep conditional expressions readable and avoid deeply nested logic.
- 📦 **Choose suitable collection types:** Use lists for ordering, sets for uniqueness, maps for keyed values, and objects for structured data.
- 🔁 **Prefer stable `for_each` keys:** Use meaningful keys for resources representing distinct entities.
- 🧹 **Normalize inputs:** Use appropriate conversion functions when the source value's type is uncertain.
- 🛡️ **Validate inputs:** Add type constraints and validation rules for important configuration values.
- 🧪 **Validate before applying:** Run `terraform fmt` and `terraform validate` before deploying changes.
- 👀 **Review execution plans:** Use `terraform plan` to inspect proposed changes before applying them.
- 🔐 **Protect sensitive data:** Avoid hardcoding secrets and understand that marking an output sensitive does not automatically remove its value from Terraform state.
- 📚 **Consult official documentation:** Confirm exact function behavior and provider-specific argument requirements.
- 💰 **Control cloud costs:** Review resources that will be created or destroyed before applying a configuration.

---

# 🎤 22. Terraform Expressions Interview Questions

### 1. What is a Terraform expression?

A Terraform expression combines values, references, operators, or function calls to produce a value that Terraform uses in configuration.

### 2. What is the difference between `var` and `local`?

`var` references input variables supplied to a configuration. `local` references named local values calculated or defined inside a `locals` block.

### 3. What is the difference between `==` and `=`?

`==` compares two values and returns a Boolean result. `=` assigns a value to an argument or defines an attribute in an object.

### 4. What is a conditional expression?

A conditional expression selects between two result values according to a Boolean condition using the `condition ? true_value : false_value` syntax.

### 5. What is the difference between a list and a set?

A list preserves positional ordering and can contain duplicate values. A set contains unique elements and does not guarantee list-style ordering.

### 6. What is the difference between a map and an object?

A map associates string keys with values sharing a compatible type. An object contains named attributes whose types can differ from one attribute to another.

### 7. What is a for expression?

A for expression iterates over a collection and builds a new collection by transforming values, optionally filtering elements, or generating key-value pairs.

### 8. What is a splat expression?

A splat expression retrieves the same attribute or element from multiple collection members using concise syntax such as `[*].id`.

### 9. What is the difference between `count` and `for_each`?

`count` identifies instances by numeric index, whereas `for_each` identifies instances by stable map keys or set members.

### 10. What does `merge()` do?

`merge()` combines multiple maps or objects into one result. If the same key appears more than once, the rightmost value takes precedence.

### 11. What does `flatten()` do?

`flatten()` removes nested list structure and produces a single-level list, making nested configuration data easier to use with collection transformations.

### 12. What is the purpose of `try()`?

`try()` returns the first argument that evaluates without a dynamic error, allowing narrowly scoped fallback behavior for uncertain attributes or conversions.

### 13. What is the purpose of `can()`?

`can()` checks whether an expression can be evaluated without an error and returns a Boolean result, which is useful in input validation.

### 14. What is the difference between `null` and `false`?

`null` represents the absence of a value, whereas `false` is a concrete Boolean value indicating a negative logical result.

### 15. What does `jsonencode()` do?

`jsonencode()` serializes a Terraform value into JSON text, which can be supplied to systems or provider arguments that expect JSON-formatted strings.

### 16. Why are locals useful?

Locals give meaningful names to repeated or calculated expressions, improving readability, reducing duplication, and helping keep infrastructure configuration consistent.

### 17. Why use `for_each` with a map?

A map provides meaningful keys that identify individual instances, which is often more stable and understandable than relying on numeric list indexes.

### 18. Can Terraform expressions create dependencies between resources?

Yes. References to managed resource attributes establish dependency relationships, allowing Terraform to determine the appropriate order for planning and applying infrastructure changes.

### 19. What is the purpose of `templatefile()`?

`templatefile()` renders an existing text template using supplied variables, enabling reusable generation of scripts, configuration files, and other text-based artifacts.

### 20. Why should Terraform configuration be validated?

Validation catches configuration errors before deployment, while planning provides a reviewable description of proposed infrastructure changes and helps identify unintended modifications.

---

# 📌 23. Additional Terraform Topics

The following topics extend beyond the 16 main topics. They are listed briefly for further study, as they build on Terraform expressions and configuration concepts.

| Additional Topic | Short Use Case |
|---|---|
| `dynamic` Blocks | Generate repeated nested provider configuration blocks. |
| `depends_on` | Declare explicit dependencies when references do not express the required ordering. |
| `lifecycle` | Control resource lifecycle behavior, such as replacement and destruction safeguards. |
| `sensitive()` | Mark a value as sensitive to reduce its display in supported CLI output contexts. |
| `nonsensitive()` | Remove a sensitivity mark when the value is safe to expose and the configuration permits it. |
| `one()` | Retrieve the only element of a collection, or return `null` for an empty collection. |
| `coalesce()` | Return the first argument that is neither null nor an empty string, subject to compatible argument types. |
| `coalescelist()` | Return the first non-empty list from a sequence of list arguments. |
| `compact()` | Remove empty strings from a list of strings. |
| `chunklist()` | Divide a list into smaller lists of a specified maximum size. |
| `setintersection()` | Find values shared by all supplied sets. |
| `setunion()` | Combine sets into one set of unique values. |
| `setsubtract()` | Return elements from one set that do not occur in another set. |
| `transpose()` | Reverse the relationship between map keys and list values. |
| `matchkeys()` | Select values whose corresponding keys match a specified key list. |
| `regex()` | Extract a match from text using a regular expression. |
| `regexall()` | Return all matches for a regular expression. |
| `can()` with `regex()` | Check whether a string matches a required format without allowing a matching error to stop evaluation. |
| `base64encode()` | Encode a string as Base64 text. |
| `base64decode()` | Decode Base64 text into a string when its content is valid. |
| `base64gzip()` | Compress and Base64-encode a string. |
| `urlencode()` | Encode text for safe use in URL components. |
| `md5()` | Calculate an MD5 hash of a string; avoid it for security-sensitive cryptographic use. |
| `sha256()` | Calculate a SHA-256 hash of a string. |
| `filebase64()` | Read a file and return its contents as Base64 text. |
| `fileset()` | Return a set of file paths matching a pattern within a directory. |
| `abspath()` | Convert a filesystem path into an absolute path. |
| `dirname()` | Retrieve the directory portion of a path. |
| `basename()` | Retrieve the final component of a path. |
| `pathexpand()` | Expand a home-directory prefix in a path where supported. |
| `cidrsubnet()` | Calculate a subnet CIDR block from a parent CIDR and subnet parameters. |
| `cidrsubnets()` | Calculate multiple subnet CIDR blocks from a parent network range. |
| `cidrhost()` | Calculate a host IP address within a CIDR block. |
| `yamldecode()` | Parse YAML text into a Terraform value. |
| `yamlencode()` | Serialize a Terraform value as YAML text. |
| `csvdecode()` | Parse CSV text into structured values. |
| `timeadd()` | Add a duration to a timestamp string. |
| `timestamp()` | Return the current timestamp, with considerations for planning and repeated evaluation. |
| `plantimestamp()` | Return the timestamp associated with the current Terraform plan. |
| `uuid()` | Generate a UUID, which should be used carefully because changing values can cause noisy plans. |
| `bcrypt()` | Generate a bcrypt password hash; consider security and evaluation implications before use. |
| `ephemeralasnull()` | Treat an ephemeral value as null in supported expression contexts. |
| Optional Object Attributes | Define object attributes that may be omitted and can have defaults in supported type constraints. |
| Variable Validation | Enforce conditions on input variables before applying infrastructure changes. |
| Preconditions | Check assumptions before a resource or output operation proceeds. |
| Postconditions | Check expected results after supported resource or data source operations. |
| `check` Blocks | Define non-blocking infrastructure assertions in supported Terraform versions. |
| `terraform console` | Evaluate expressions interactively for testing and debugging. |
| `terraform test` | Run configuration tests using supported Terraform test files. |

---

# 🔗 24. Official Documentation

Use the official documentation to verify function signatures, language behavior, version compatibility, and provider-specific configuration.

- 📘 [Terraform Language Documentation](https://developer.hashicorp.com/terraform/language)
- 🧩 [Terraform Expressions](https://developer.hashicorp.com/terraform/language/expressions)
- 🔤 [Terraform Types and Values](https://developer.hashicorp.com/terraform/language/expressions/types)
- 🔗 [Terraform References](https://developer.hashicorp.com/terraform/language/expressions/references)
- 🔀 [Conditional Expressions](https://developer.hashicorp.com/terraform/language/expressions/conditionals)
- 📝 [Strings and Templates](https://developer.hashicorp.com/terraform/language/expressions/strings)
- 📦 [Collection and Structural Types](https://developer.hashicorp.com/terraform/language/expressions/type-constraints)
- 🔁 [For Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)
- 🌟 [Splat Expressions](https://developer.hashicorp.com/terraform/language/expressions/splat)
- 🛠️ [Terraform Functions](https://developer.hashicorp.com/terraform/language/functions)
- 🏗️ [`count` Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/count)
- 🔄 [`for_each` Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
- 🧪 [Terraform CLI Commands](https://developer.hashicorp.com/terraform/cli/commands)
- ☁️ [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---

## 🌟 Support & Connect

<p align="center">
  <b>🎉 Congratulations! You have completed the Terraform Expressions guide.</b>
<p align="center">
  💜 If this repository helped you learn Terraform Expressions, please consider giving it a ⭐!
  <br>
  📚 Keep Learning • 🛠️ Keep Practicing • 🚀 Keep Building
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform">
  <img src="https://img.shields.io/badge/Learning-Never%20Stops-2EA44F?style=for-the-badge" alt="Learning">
</p>

<p align="center">
  <b>✨ Learn Today. Automate Tomorrow. Build the Future. ✨</b>
  <br><br>
  Made with ❤️ and ☁️ for the Terraform Community
</p>

<p align="center">
  <sub>📌 Keep exploring. Keep experimenting. Keep growing!</sub>
</p>

---