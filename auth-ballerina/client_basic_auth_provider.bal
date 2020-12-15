// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Represents the Basic Auth authentication configurations.
#
# + username - Username for Basic Auth authentication
# + password - Password for Basic Auth authentication
public type Credential record {|
    string username;
    string password;
|};

# Represents the client Basic Auth provider. This uses the `auth:Credential` configuration provided and generes the
# token for Basic Auth authentication.
# ```ballerina
#  auth:Credential config = {
#      username: "tom",
#      password: "123"
#  }
#  auth:ClientBasicAuthProvider provider = new(config);
#  ```
public class ClientBasicAuthProvider {

    Credential credential;

    # Provides authentication based on the provided Basic Auth configurations.
    #
    # + credential - Credential configurations
    public isolated function init(Credential credential) {
        self.credential = credential;
    }

    # Generates a token for Basic Auth authentication.
    # ```ballerina
    # string|auth:Error token = provider.generateToken();
    # ```
    #
    # + return - The generated token or else an `auth:Error` occurred during the validation
    public isolated function generateToken() returns string|Error {
        if (self.credential.username == "" || self.credential.password == "") {
            return prepareError("Username or password cannot be empty.");
        }
        string token = self.credential.username + ":" + self.credential.password;
        return token.toBytes().toBase64();
    }
}
