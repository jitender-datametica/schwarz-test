CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_BUCHUNGSSCHLUESSEL_1
-- P0516, srom, 22.03.2016 auf neue Struktur umstellen
-- awol2209 25.02.2020: umgehängt auf neue Tabelle
(
 buchungsschluessel_id
,buchungsschluessel_bez
,buchungsschluessel_lang_bez
)
AS
   SELECT
      buchungsschluessel_id, buchungsschluessel_bez, CAST(buchungsschluessel_id||' '||buchungsschluessel_bez AS VARCHAR(111)) buchungsschluessel_lang_bez
   FROM DBP_V_ODS.v_buchungsschluessel_spr_zu_1
   where spr_id = 124;