CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_BESTWERTFORTSCHREIBUNG_1 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        dat,
        owg_id,
        arthiertyp_id,
        wrg_id,
        umsatz_plan_brutto_owg,
        wareneingang_brutto_owg,
        schlussbestand_vormonat_brutto_owg,
        datzeit_pflege
FROM DBP_MSI_DATA.TS_BESTWERTFORTSCHREIBUNG_1 ;