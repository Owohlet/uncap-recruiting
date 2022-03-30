Assignment 1: Explain the roles of user.rb, user_profile.rb and user_permission.rb

Most recent applications prefer to separate the user model from the profile of the users in that model. The usual goal for this is to preserve the user model for authentication purposes while having a separate model for the complete profile of the users. This was used here.

User.rb plays the role of modeling the core user as an authenticable entity. Devise and Devise extension gems like devise_invitable and devise_security were also probably used. This entity(table) was related to other entities(tables) such as profiles, organization, application etc. It is also the core entity on which the invitable module is installed on.

User_profile.rb extends the core profile of the authenticated user providing fields like first_name, last_name and a map for gender. Is related to country(table) as well.

User_permission.rb table is a join-table linking a user, her organization and her permission in that organization. Because a user can be a main_founder or a co_founder, it becomes important to have a permission table to model that separately (as it can scale). User_permission allows the user to have multiple entries through has_many-belongs_to relationship, which was probably done to allow the user create more than one organization.



Assignment 2: Can you think of a better solution for handling repayments of larger amounts than are due?

I worked in a microfinance institution that had to create a repayment plan for customer loans. The repayments had interest and there were penalties for defaulting. Our solution was to: 
1, pre-create all the repayment objects at the time of loan creation.
2, add a current_balance field that monitors if the the customer had paid in excess or is due to pay more. This current_balance field per repayment is used to calculate the amount due for the next repayment automatically.
3, add a boolean field (completed? true/false) field that checked if the repayment object had been completed instead of running possible O(n) computations each time.

This way you will always know that each repayment will be completed in full before another repayment starts, so you only need to check the last completed repayment to fill the next one. Also repayments will by default be balanced.
