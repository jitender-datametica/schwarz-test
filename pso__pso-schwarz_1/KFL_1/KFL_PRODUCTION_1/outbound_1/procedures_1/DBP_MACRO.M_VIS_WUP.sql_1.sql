CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_wup(IN P_MANDANT_ID BIGNUMERIC, IN P_WUP_ID BIGNUMERIC, IN P_DAT_VON STRING, IN P_DAT_EROEFFNUNG STRING, IN P_DAT_BIS STRING, IN P_UEBERNAHME_VON STRING, IN P_KUNDENFAKTOR BIGNUMERIC, IN P_UMSATZ_EA_EUR BIGNUMERIC, IN P_UMSATZ_EA_LAND BIGNUMERIC, IN P_UMSATZ_ERWARTUNG_EUR BIGNUMERIC, IN P_DAT_WIEDEREROEFFNUNG STRING, IN P_EINWOHNER_ANZAHL BIGNUMERIC, OUT OUT_PARAM STRING )
BEGIN
DECLARE var_currentDate DATE;
DECLARE var_datvon DATE;
DECLARE var_dateroe DATE;
DECLARE var_datbis DATE;
BEGIN
SET var_currentDate  =  (SELECT DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 5 DAY));
SET var_datvon  =  (SELECT dat_von
FROM dbp_data.wup_1
WHERE mandant_id = P_MANDANT_ID AND wup_id = P_WUP_ID);
SET var_dateroe  =  (SELECT dat_eroeffnung
FROM dbp_data.wup_1
WHERE mandant_id = P_MANDANT_ID AND wup_id = P_WUP_ID);
SET var_datbis  =  (SELECT dat_bis
FROM dbp_data.wup_1
WHERE mandant_id = P_MANDANT_ID AND wup_id = P_WUP_ID);

CASE WHEN (((DATE(P_DAT_VON) = DATE(var_datvon))
OR ((DATE(P_DAT_VON) <> DATE(var_datvon)) AND (DATE(P_DAT_VON) BETWEEN DATE(var_currentdate)
AND DATE('2090-12-31')))
)
AND
((DATE(P_DAT_EROEFFNUNG) = DATE(var_dateroe))
OR ((DATE(P_DAT_EROEFFNUNG) <> DATE(var_dateroe))
AND (DATE(P_DAT_EROEFFNUNG) BETWEEN DATE(var_currentdate)
AND DATE('2090-12-31')))
)
AND
((DATE(P_DAT_BIS) = DATE(var_datbis))
OR ((DATE(P_DAT_BIS) <> DATE(var_datbis))
AND (DATE(P_DAT_BIS) BETWEEN DATE(var_currentdate) AND DATE('9999-12-31')))
)
)
THEN
UPDATE dbp_data.wup_1 SET
    dat_von = CAST(P_DAT_VON AS DATE),
    dat_eroeffnung = CAST(P_DAT_EROEFFNUNG AS DATE),
    dat_bis = CAST(P_DAT_BIS AS DATE),
    uebernahme_von = P_UEBERNAHME_VON,
    kundenfaktor = P_KUNDENFAKTOR,
    umsatz_ea_eur = CAST(P_UMSATZ_EA_EUR AS NUMERIC),
    umsatz_ea_land = CAST(P_UMSATZ_EA_LAND AS NUMERIC),
    umsatz_erwartung_eur = CAST(P_UMSATZ_ERWARTUNG_EUR AS NUMERIC),
    dat_wiedereroeffnung = CAST(P_DAT_WIEDEREROEFFNUNG AS DATE),
    einwohner_anzahl = CAST(P_EINWOHNER_ANZAHL AS INTEGER)
WHERE mandant_id = P_MANDANT_ID AND wup_id = P_WUP_ID;
Commit transaction;
SET out_param = 'WUP_is_updated';
      RETURN; 
    ELSE
    SET out_param = 'WUP_not_updated';
      RETURN;
  END CASE;
END;
END;
