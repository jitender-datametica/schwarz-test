CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_KJMO_SPR_ZU_2
--AL 26.01.2012 mo_bez_lang --> CAST to varchar(20)
--sschücke 30.01.2012 kj und gj -> CAST to SMALLINT
(
spr_id,
mo_bez,
kjmo,
kj,
gj,
gjmo,
mo_bez_lang
)
AS
   SELECT spr_id,
   kjmo_bez,
   kjmo,
   CAST (SUBSTRING(kjmo, 0, 4) AS SMALLINT) AS kj,
   CAST (SUBSTRING(gjmo, 0, 4) AS SMALLINT) AS gj,
   gjmo,
   CAST (kjmo_bez_lang AS VARCHAR(20)) AS kjmo_bez_lang
   FROM dbp_view.v_kjmo_spr_zu_2 WHERE spr_id=22 AND kjmo >=200201;