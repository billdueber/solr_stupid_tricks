#!/bin/sh
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FILES=$*
URL='http://localhost:8983/solr/update/json?wt=json'

# Clear it out
echo
echo "Clearing out solr (delete all)"
curl $URL -s -d '{"delete": { "query":"*:*" }, "commit": {}}' -H 'Content-type:application/json' > /dev/null

echo 'Posting file(s)'
for f in $FILES; do
  echo "  - $f"
  curl $URL -s -d @$f -H 'Content-type:application/json' > /dev/null
done

#send the commit command to make sure all the changes are flushed and visible
echo "Final commit"
curl $URL -s -d '{"commit": {}}' -H 'Content-type:application/json' > /dev/null
echo
