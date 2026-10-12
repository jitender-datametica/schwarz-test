CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MARA_EMPF
(
art_id,
mandant_id,
UMMAT_SAP,
dat_von,
dat_bis
)
AS
   SELECT
   art_id,
   mandant_id,
   CASE WHEN artikelart_id = 'MWST' THEN TO_VARCHAR(kl_art_id, 'FM0000')
   ELSE CASE -- Darstellung in KMO mit 8 Stellen
   WHEN mandant_id <> 1 THEN TO_VARCHAR(kl_art_id, 'FM00000000')
   -- Darstellung in DE mit 7 Stellen
   WHEN mandant_id =  1 AND art_id >0 THEN TO_VARCHAR(kl_art_id, 'FM0000000')
   -- DE Warengruppenwertartikel
   WHEN mandant_id =  1 AND art_id <0 THEN '00' || CAST(TRUNC(art_id/100) AS VARCHAR(10))
   END
   END AS UMMAT_SAP,
   dat_von,
   dat_bis
   FROM dbp_view.v_art
   WHERE dat_bis='9999-12-31';