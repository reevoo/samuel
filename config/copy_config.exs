use Mix.Config

config :samuel,
  guidelines_message: """
  Here's the guidelines!

  - If you read a Pull Request, leave a comment! Don't worry about not being
    the expert.
  - If it's on CI, has it gone green? If it's not on CI, pull the branch, run
    the tests and leave a comment with the results.
  - Did the code need explaining (usually through comments)? If so, the code
    needs making clearer.
  - How is the code tested? What are the edge cases - are they tested? How
    does the code behave when something goes wrong?
  - How is the new feature documented?
  - Can we write less code and do the same thing?

  - If you think the code is fine, use "LGTM" (Looks Good To Me).
  - If you think the code is fine, but you are unsure of the context, use
    "LGTMBWTFDIK" (Looks Good to Me, but What Do I Know).
  """
