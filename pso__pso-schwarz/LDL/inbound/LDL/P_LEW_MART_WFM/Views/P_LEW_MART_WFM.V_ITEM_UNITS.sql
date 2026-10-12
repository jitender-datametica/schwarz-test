CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_UNITS
AS

   /*
   View for the units of items in relation to logistic variant
   Get the units, hist units and units description of items for all orders (incl. hist orders). Only the logistic variant (1,2 and 3) will be select:
   */
   SELECT DISTINCT
   itm.client_id AS client_id,
   cntry.src_country_lidl_cd                                     AS country_cd,
   Cast(Coalesce(itm.config_item_cd, itm.src_matnr) AS BIGINT)   AS orig_itm_nr,
   Cast(itm.src_matnr AS BIGINT)                                 AS itm_id,
   Bestel.uom_cd_base                                            AS Basismengeneinheit,
   Bestel.uom_cd_order                                           AS Bestellmenge,
   Cast(Descr.uom_descr_ext_3ch AS VARCHAR(3))                   AS MEINH,
   Cast(Descr.uom_descr_long AS VARCHAR(30))                     AS MEINH_BEZ,
   Cast(UOM_hist.conv_to_base_numerator    AS INTEGER)           AS Zaehler,
   Cast(UOM_hist.conv_to_base_denominator    AS INTEGER)         AS Nenner,
   Cast(UOM_hist.uom_cd_sub AS CHAR(3))                           AS ext_desc_3ch_sub
   FROM p_lew_core_ac.v_item itm
   INNER JOIN p_lew_core_ac.v_client_migration_per AS mig
   ON mig.client_id = itm.client_id
   AND Current_Date - 1 BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to
   INNER JOIN p_lew_core_ac.v_pinfo_header_hist AS Bestel
   ON Bestel.item_sid = itm.item_sid
   AND itm.client_id = Bestel.client_id
   AND Bestel.deleted_fg = 0
   INNER JOIN p_lew_core_ac.v_item_unit_of_measurement AS UOM
   ON UOM.item_sid = itm.item_sid
   INNER JOIN p_lew_core_ac.v_country cntry
   ON cntry.country_sid = itm.client_id
   INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist AS UOM_hist
   ON UOM_hist.item_sid = itm.item_sid
   AND UOM.uom_sid = UOM_hist.uom_sid
   AND UOM_hist.deleted_fg = 0
   INNER JOIN p_lew_core_ac.v_unit_of_measurement_descr AS Descr
   ON Descr.uom_sid = UOM.uom_sid
   AND descr.lang_cd IN ('@', 'EN' )

   WHERE 1=1
   AND itm.log_var_cd IN (1,2,3)
;