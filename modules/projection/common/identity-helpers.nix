{ input }:
if input.current.user.meta.displayName != null then
  input.current.user.meta.displayName
else
  input.userId
