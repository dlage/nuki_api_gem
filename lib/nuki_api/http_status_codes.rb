# frozen_string_literal: true

module NukiApi
  module HttpStatusCodes
    HTTP_OK_CODE = 200
    HTTP_NO_CONTENT = 204 # OK

    HTTP_BAD_REQUEST_CODE = 400 # Bad parameter
    HTTP_UNAUTHORIZED_CODE = 401 # Not authorized
    HTTP_NOT_PAID_CODE = 402 # Account not payed
    HTTP_FORBIDDEN_CODE = 403
    HTTP_NOT_FOUND_CODE = 404
    HTTP_PARAMETER_CONFLICT_CODE = 409 # Parameter conflicts
    HTTP_LOCKED = 423 # Locked
    HTTP_ACCOUNT_UPGRADE_REQUIRED = 426 # Account upgrade required
    HTTP_UNPROCESSABLE_ENTITY_CODE = 429
  end
end
