
# Custom User-Defined Functions in Flink
This guide will lead you through the process of creating, compiling, and deploying a user-defined functions (UDFs) in Apache Flink using DataSQRL. We will specifically focus on a function called MyScalarFunction, which will double the values of input numbers, and then deploy and execute the function in Flink.

## Introduction
User-defined functions (UDFs) in Flink are powerful tools that allow for the extension of the system's built-in functionality. UDFs can be used to perform operations on data that are not covered by the built-in functions.

## Creating a User-Defined Function
1. **Project Structure:** The `myjavafunction` folder contains a sample Java project, demonstrating the structure and necessary components of a Flink UDF.

2. **Defining the Function:** The main component of this project is the MyScalarFunction class. This is the implementation of a custom flink function. DataSQRL recognizes flink functions that extend UserDefinedFunction.

3. **ServiceLoader Entry:** The function must be registered with a ServiceLoader entry. This is essential for DataSQRL to recognize and use your UDF.
- **AutoService Library:** The example includes the AutoService library by Google, simplifying the creation of ServiceLoader META-INF manifest entries.

4. **Jar Compiling:** Compile the sample project and build a jar. This jar is what DataSQRL will use to discover your function. It reads the manifest entries for any UserDefinedFunction classes and load them into DataSQRL for use in queries. It can be placed into any folder relative to the sqrl root folder which will translate to the import path. In the example, we will use the `target` directory that the compilation process creates.

## SQRL Compilation and Packaging
1. **SQRL Compilation:** Compile the SQRL using DataSQRL's command interface, which prepares your script for deployment in the Flink environment.

```shell
docker run --rm -v $PWD:/build datasqrl/cmd:latest compile myudf.sqrl
```

## Deployment and Testing
### Run Example
```shell
docker run -it -p 8888:8888 --rm -v $PWD:/build datasqrl/cmd:latest run myudf.sqrl
```
### Creating and Testing Records
1. Creating a Record: Test the function by creating a record via a GraphQL query.
```shell
curl -X POST 'http://localhost:8888/graphql' \
    -H 'Content-Type: application/graphql' \
    -d '
mutation {
  InputData(event: { val: 2 }) {
    val
  }
}'
```

2. Verifying Function Execution: Confirm the function's execution and output with another GraphQL query. You should see two values come back, 2 and 4.

```shell
curl -X POST 'http://localhost:8888/graphql' \
    -H 'Content-Type: application/graphql' \
    -d '
query {
  MyTable {
    val
    myFnc
  }
}'
```