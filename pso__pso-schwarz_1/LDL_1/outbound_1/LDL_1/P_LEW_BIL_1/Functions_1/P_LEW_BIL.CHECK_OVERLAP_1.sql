CREATE OR REPLACE FUNCTION ldl_p_lew_bil.check_overlap(
  S1 DATE,
  E1 DATE,
  S2 DATE,
  E2 DATE
)
RETURNS BOOL
LANGUAGE js AS r"""

// Handle NULL inputs
if (S1 === null || E1 === null || S2 === null || E2 === null) {
  return null;
}

var result =  (S1 > S2 && !(S1 >= E2 && E1 >= E2)) ||
              (S2 > S1 && !(S2 >= E1 && E2 >= E1)) ||
              (S1.getTime() === S2.getTime() && (E1.getTime() === E2.getTime() || E1.getTime() !== E2.getTime()));

return result;

""";