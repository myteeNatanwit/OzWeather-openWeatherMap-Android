
import Foundation

/* validation codes
 Validation Code    Message
 LA01    Field code fail valid algorithm (credit card..).
 LA02    Tag missing or out of sequence in associated group.
 LA03    Field data is not in range.
 LA04    Maximum field length [nnn] exceeded
 LA05    Minimum field length not match
 LA06    Invalid Text field - content non alphanumeric chars
 LA07    Invalid Date8 format
 LA08    Invalid restricted name text characters
 LA09    Mandatory field not present or complete
 LA11    Invalid $ value
 LA15    Invalid $c value
 LA17    Mandatory field cannot empty
 LA23    Invalid name text characters
 LA38    Invalid question field -Y/N only
 LA40    Invalid integer field - no decimal
 LA42    Number of occurrences for this field exceeded
 LA43    Invalid address text characters
 Table 8. Global Validation

 */

func LA07isNotEmpty(_ field: String) -> Bool {
    return field.count > 0;
}

