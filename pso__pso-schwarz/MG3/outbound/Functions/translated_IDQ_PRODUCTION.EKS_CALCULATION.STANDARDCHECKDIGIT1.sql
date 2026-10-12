CREATE OR REPLACE FUNCTION idq_production_eks_calculation.standardcheckdigit1(EAN11 STRING)
RETURNS STRING
LANGUAGE js
AS """
  if (EAN11 === null || EAN11 === undefined) {
    return null;
  }

  var EAN11Pad = String(EAN11);
  
  if (!Number.isInteger(Number(EAN11Pad))) { 
    return null; 
  }

  var EvenSum =
    Number(EAN11Pad.substring(1, 2)) +
    Number(EAN11Pad.substring(3, 4)) +
    Number(EAN11Pad.substring(5, 6)) +
    Number(EAN11Pad.substring(7, 8)) +
    Number(EAN11Pad.substring(9, 10)) +
    Number(EAN11Pad.substring(11, 12)) +
    Number(EAN11Pad.substring(13, 14)) +
    Number(EAN11Pad.substring(15, 16));

  var OddSum =
    Number(EAN11Pad.substring(0, 1)) +
    Number(EAN11Pad.substring(2, 3)) +
    Number(EAN11Pad.substring(4, 5)) +
    Number(EAN11Pad.substring(6, 7)) +
    Number(EAN11Pad.substring(8, 9)) +
    Number(EAN11Pad.substring(10, 11)) +
    Number(EAN11Pad.substring(12, 13)) +
    Number(EAN11Pad.substring(14, 15)) +
    Number(EAN11Pad.substring(16, 17));

  var Total = String(EvenSum + (OddSum * 3));
  var ModNo = Number(Total.substring(Total.length - 1, Total.length));
  
  var Ret = 0;
  if (ModNo != 0) {
    Ret = 10 - ModNo;
  }

  return String(Ret);
""";