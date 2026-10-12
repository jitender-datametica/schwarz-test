CREATE OR REPLACE PROCEDURE `dbp_macro.sp_vis_puk_monat_kommentar`(
  puk_id FLOAT64,
  mandant_id FLOAT64,
  puk_typ_id FLOAT64,
  kennzahl_id FLOAT64,
  kjmo FLOAT64,
  puk_parent_id FLOAT64,
  ursache_kjmo STRING,
  massnahme_kjmo STRING
)
BEGIN
  -- Start transaction to mirror Snowflake logic
  BEGIN TRANSACTION;

  MERGE INTO `dbp_data.vis_puk_monat_kommentar_1` AS target
  USING (
    SELECT 
      puk_id AS puk_id,
      mandant_id AS mandant_id,
      puk_typ_id AS puk_typ_id,
      kennzahl_id AS kennzahl_id,
      kjmo AS kjmo,
      puk_parent_id AS puk_parent_id,
      ursache_kjmo AS ursache_kjmo,
      massnahme_kjmo AS massnahme_kjmo
  ) AS source
  ON target.mandant_id = source.mandant_id
    AND target.kjmo = source.kjmo
    AND target.kennzahl_id = source.kennzahl_id
    AND target.puk_typ_id = source.puk_typ_id
    AND target.puk_id = source.puk_id

  WHEN MATCHED THEN
    UPDATE SET 
      target.puk_parent_id = cast(source.puk_parent_id as int64),
      target.ursache_kjmo = source.ursache_kjmo,
      target.massnahme_kjmo = source.massnahme_kjmo,
      target.zeit_aktualisierung = CURRENT_DATETIME()

  WHEN NOT MATCHED THEN
    INSERT (
      mandant_id,
      kjmo,
      kennzahl_id,
      puk_typ_id,
      puk_id,
      puk_parent_id,
      ursache_kjmo,
      massnahme_kjmo,
      zeit_aktualisierung
    )
    VALUES (
      cast(source.mandant_id as int64),
      cast(source.kjmo as int64),
      cast(source.kennzahl_id as int64),
      cast(source.puk_typ_id as int64),
      cast(source.puk_id as int64),
      cast(source.puk_parent_id as int64),
      source.ursache_kjmo,
      source.massnahme_kjmo,
      CURRENT_DATETIME()
    );

  COMMIT TRANSACTION;

EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;