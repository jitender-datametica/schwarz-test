create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MCX_BEREICH_SPR_ZU(
	BER_ID,
	BER_BEZ,
	BER_BEZ_CZ,
	BER_BEZ_PL,
	BER_BEZ_SK,
	BER_BEZ_HR,
	BER_BEZ_RO,
	BER_BEZ_BG
) as
-- 20180502 twie: SPEC0037245 Neuanlage Sprachview Bereich in Maritz
--                           Bereich wird in DWH generiert, existiert nicht im Quellsystem Maritz

   SELECT

   ber_id
   , MAX(CASE WHEN spr_id =   22 THEN ber_bez ELSE NULL END)  AS ber_bez   --standard=deutsch
   , MAX(CASE WHEN spr_id = 124 THEN ber_bez ELSE NULL END)  AS ber_bez_cz
   , MAX(CASE WHEN spr_id =   90 THEN ber_bez ELSE NULL END)  AS ber_bez_pl
   , MAX(CASE WHEN spr_id = 108 THEN ber_bez ELSE NULL END)  AS ber_bez_sk
   , MAX(CASE WHEN spr_id =   65 THEN ber_bez ELSE NULL END)  AS ber_bez_hr
   , MAX(CASE WHEN spr_id =   95 THEN ber_bez ELSE NULL END)  AS ber_bez_ro
   , MAX(CASE WHEN spr_id =   18 THEN ber_bez ELSE NULL END)  AS ber_bez_bg

   FROM dbp_view.v_mcx_bereich_spr_zu

   GROUP BY ber_id;