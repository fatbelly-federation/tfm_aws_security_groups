Create some common, useful security groups

https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html

* You can specify allow rules, but not deny rules.
* You can specify separate rules for inbound and outbound traffic.
* When you create a security group, it has no inbound rules. Therefore, no inbound traffic originating from another host to your instance is allowed until you add inbound rules to the security group.
* By default, a security group includes an outbound rule that allows all outbound traffic. You can remove the rule and add outbound rules that allow specific outbound traffic only. If your security group has no outbound rules, no outbound traffic originating from your instance is allowed.
* Security groups are stateful — if you send a request from your instance, the response traffic for that request is allowed to flow in regardless of inbound security group rules. Responses to allowed inbound traffic are allowed to flow out, regardless of outbound rules. 
