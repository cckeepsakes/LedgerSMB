Feature: setup.pl database creation and migration functionalities
  In order to create company databases or migrate company databases
  from earlier versions and SQL-Ledger, we want system admins to be
  able to use the setup.pl functionalities involved.



Background:
  Given a database super-user
    And a LedgerSMB instance


Scenario: Create a company *with* CoA
 Given a non-existent company named "setup-test"
   And a non-existent user named "the-user"
  When I navigate to the setup login page
   And I log into the company using the super-user credentials
  Then I should see the company creation page
  When I confirm database creation with these parameters:
      | parameter name    | value       |
      | Country code      | us          |
      | Chart of accounts | General.sql |
      | Templates         | demo        |
  Then I should see the user creation page
  When I create a user with these values:
      | label              | value            |
      | Username           | the-user         |
      | Password           | abcd3fg          |
      | Salutation         | Mr.              |
      | First Name         | A                |
      | Last name          | Dmin             |
      | Employee Number    | 00000001         |
      | Date of Birth      | 09/01/2006       |
      | Tax ID/SSN         | 00000002         |
      | Country            | United States    |
      | Assign Permissions | Full Permissions |
  Then I should see the setup confirmation page


Scenario: List users in a company
 Given an existing company named "setup-test"
  When I navigate to the setup login page
   And I log into the company using the super-user credentials
  Then I should see the setup admin page
  When I request the users list
  Then I should see the setup user list page
   And I should see the table of available users:
      | Username |
      | the-user |


Scenario: Edit user in a company
 Given an existing company named "setup-test"
  When I navigate to the setup login page
   And I log into the company using the super-user credentials
  Then I should see the setup admin page
  When I request the users list
  Then I should see the setup user list page
   And I should see the table of available users:
      | Username |
      | the-user |
  When I request the user overview for "the-user"
  Then I should see the edit user page



Scenario: Add user to a company
 Given an existing company named "setup-test"
   And a non-existent user named "the-user2"
  When I navigate to the setup login page
   And I log into the company using the super-user credentials
  Then I should see the setup admin page
  When I request to add a user
  Then I should see the user creation page
  When I create a user with these values:
      | label              | value            |
      | Username           | the-user2        |
      | Password           | klm2fly          |
      | Salutation         | Mr.              |
      | First Name         | Common           |
      | Last name          | User             |
      | Employee Number    | 00000010         |
      | Date of Birth      | 09/06/2006       |
      | Tax ID/SSN         | 00000003         |
      | Country            | United States    |
      | Assign Permissions | No changes       |
  Then I should see the setup confirmation page
  When I navigate to the setup login page
   And I log into the company using the super-user credentials
  Then I should see the setup admin page
  When I request the users list
  Then I should see the setup user list page
   And I should see the table of available users:
      | Username  |
      | the-user  |
      | the-user2 |

Scenario: Copy a company
 Given a non-existent company named "setup-test2"
   And an existing company named "setup-test"
  When I navigate to the setup login page
   And I log into the company using the super-user credentials
  Then I should see the setup admin page
  When I copy the company to "setup-test2"
  Then I should see the setup confirmation page
  When I navigate to the setup login page
   And I log into "setup-test2" using the super-user credentials
  Then I should see the setup admin page