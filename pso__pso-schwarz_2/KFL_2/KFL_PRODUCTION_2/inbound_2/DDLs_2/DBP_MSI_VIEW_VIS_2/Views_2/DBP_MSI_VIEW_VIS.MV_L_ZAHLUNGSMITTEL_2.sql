CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_ZAHLUNGSMITTEL_2
-- P0516, srom, 22.03.2016 auf neue Struktur umstellen
(
mandant_id
,zahlungsmittel_id
)
AS
   SELECT
   mandant_id, zahlungsmittel_id
   /*
   ,zahlungsmittel_bez
   ,CASE WHEN zahlungsmittel_id = 0
   THEN CAST ( (zahlungsmittel_id (FORMAT '999')) || ' ' || zahlungsmittel_bez AS VARCHAR (60))
   ELSE CAST ( (zahlungsmittel_id (FORMAT '99')) || ' ' || zahlungsmittel_bez AS VARCHAR (60))
   end                        AS  zahlungsmittel_lang_bez
   */
   FROM
   dbp_v_ods.v_l_zahlungsmittel_2;