Pull request guidelines
-----------------------

- Changes should have corresponding unit and/or integration tests.
- Affected public classes and functions should have accurate documentation.
- Source code formatting should be hygienic:
  - Use 2-space indentation.
  - Do not use hard tabs.
  - No trailing or inconsistent whitespace.
  - No exceptionally long lines.
  - Variable names should be clear but concise.
- Commit history should be relatively hygienic:
  - Roughly one commit per logical change.
  - Log messages are clear and understandable.
  - Few (or no) "merge" commits.
  - Hint: `git rebase -i` is great for cleaning up a branch.


Pull requests for branches that are still in development should be prefixed with WIP: 
so that they don't get accidently merged. Remove WIP: once the pull request is 
considered finalized and ready to be reviewed and merged.

License
-------

By contributing code to Green Button Data, you are agreeing to release it under the 
[Simplified BSD License](https://raw.githubusercontent.com/VerdigrisTech/green-button-data/master/LICENSE.txt).
