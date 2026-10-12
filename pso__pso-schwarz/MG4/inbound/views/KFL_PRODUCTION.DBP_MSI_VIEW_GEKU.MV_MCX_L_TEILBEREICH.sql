create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MCX_L_TEILBEREICH(
	TEILBEREICH_ID,
	BER_ID
) as
-- 20180509 twie: SPEC0037245 Neuanlage Lookup Teilbereich in Maritz
--                           Teilbereich wird in DWH generiert, existiert nicht im Quellsystem Maritz
-- 20190617 twie: NSR0798599 teilbereich_id von SMALLINT zu INT, damit einheitlich zu audimex Feld

   SELECT

   CAST(teilbereich_id AS INTEGER) AS teilbereich_id
   , ber_id

   FROM dbp_view.v_mcx_l_teilbereich;