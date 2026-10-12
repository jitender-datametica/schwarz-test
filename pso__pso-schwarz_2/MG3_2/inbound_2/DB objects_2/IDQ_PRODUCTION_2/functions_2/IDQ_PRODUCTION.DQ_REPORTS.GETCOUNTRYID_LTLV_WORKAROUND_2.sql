CREATE OR REPLACE FUNCTION IDQ_PRODUCTION.DQ_REPORTS.GETCOUNTRYID_LTLV_WORKAROUND(""I"" VARCHAR(16777216), ""J"" NUMBER(38,0))
RETURNS NUMBER(38,0)
LANGUAGE PYTHON
RUNTIME_VERSION = '3.9'
HANDLER = 'getCountryID'
AS '
def getCountryID(i, j):
    
    if (i == ''BE''):
        return 2;
    
    if (i == ''BG''):
        return 3;
        
    if (i == ''CY''): 
        return 4;
        
    if (i == ''DE''):
        return 5;

    if (i == ''DK''):
        return 6;
    
    if (i == ''FI''):
        return 7;
    
    if (i == ''FR''):
        return 8;

    if (i == ''GR''):
        return 9;    

    if (i == ''GB''):
        return 10;
    
    if (i == ''NL''):
        return 11;

    if (i == ''IE''):
        return 12;

    if (i == ''IT''):
        return 13;
    
    if (i == ''CS''):
        return 14;
    
    if (i == ''HR''):
        return 15;

    if (i == ''LT''):
        return 16;

    if (i == ''MT''):
        return 17;
        
    if (i == ''NIE''):
        return 18;

    if (i == ''AT''):
        return 19;
        
    if (i == ''PL''):
        return 20;

    if (i == ''PT''):
        return 21;
    
    if (i == ''RO''):
        return 22;
    
    if (i == ''SE''):
        return 23;
        
    if (i == ''CH''):
        return 24;
    
    if (i == ''RS_2''):
        return 25;

    if (i == ''SK''):
        return 26;

    if (i == ''SI''):
        return 27;

    if (i == ''ES''):
        return 28;

    if (i == ''CZ''):
        return 29;

    if (i == ''HU''):
        return 30;
     
    if (i == ''US''):
        return 31;

    if (i == ''LV'' and str(j)[0:2] == ''79'' ):
        return 33;  
     
    if (i == ''LV'' and str(j)[0:2] == ''78'' ):
        return 34;

    if (i == ''EE''):
        return 33;

    if (i == ''LV''):
        return 34; 

    return 1;
    
  ';