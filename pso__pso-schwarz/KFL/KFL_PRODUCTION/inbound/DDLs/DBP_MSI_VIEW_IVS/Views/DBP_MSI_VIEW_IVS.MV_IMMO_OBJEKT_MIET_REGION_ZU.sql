CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_IMMO_OBJEKT_MIET_REGION_ZU as
      -- 2008-09-09
      -- ZUORDNUNG Mietregion und Bundesland
      -- Basis PLZ-Definition FB
      -- 2010KW28 Erweiterung Case Prüfung PLZ Range zu Bundesland
      -- 2012KW19 Erweiterung Region/Kategorie BG + Spalte bl_id (CHAR)
      -- 2013KW03 Umstellung Ermittlung miet_region_id, miet_bundesland_id
      SELECT
      z.mandant_id,
      z.immo_objekt_id,
      COALESCE(o.objekt_plz, '-1') AS objekt_plz,
      z.miet_region_id,
      z.bl_id AS miet_bundesland_id
      FROM dbp_view.v_ivs_immo_obj_miet_region_zu z
      INNER JOIN dbp_view.v_ivs_immo_objekt_per o
      ON z.mandant_id = o.mandant_id
      AND z.immo_objekt_id = o.immo_objekt_id
      AND o.dat_bis = '9999-12-31'
;