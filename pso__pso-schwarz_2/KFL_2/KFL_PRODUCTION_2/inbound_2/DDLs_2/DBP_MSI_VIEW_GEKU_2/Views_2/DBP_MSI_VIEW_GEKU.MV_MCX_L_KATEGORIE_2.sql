CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_L_KATEGORIE_2
(
kat_id
,teilbereich_id
)
AS
-- 20180502 twie: SPEC0037245 Neuanlage Lookup Kategorie in Maritz
--                           Kategorie wird in DWH generiert, existiert nicht im Quellsystem Maritz
-- 20190617 twie: NSR0798599 teilbereich_id von SMALLINT zu INT, damit einheitlich zu audimex Feld

   SELECT

   kat_id
   , CAST(teilbereich_id AS INTEGER) AS teilbereich_id

   FROM dbp_view.v_mcx_l_kategorie_2;