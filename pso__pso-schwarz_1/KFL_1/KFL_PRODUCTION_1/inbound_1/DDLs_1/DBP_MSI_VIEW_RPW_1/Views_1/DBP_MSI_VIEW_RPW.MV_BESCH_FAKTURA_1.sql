CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BESCH_FAKTURA_1
       (
       mandant_id
       ,faktura_beleg_id
       ,wrg_id
       ,dat_faktura
       ,fakturaart_id
       ,faktura_status_id
       ,verkaufsorganisation_id
       ,kalk_schema_id
       ,auftraggeber_id
       ,storno_fg
       ,dat_erstellung
       ,system_id
       )
       AS
          SELECT
          mandant_id,
          faktura_beleg_id,
          wrg_id,
          dat_faktura,
          fakturaart_id,
          faktura_status_id,
          verkaufsorganisation_id,
          kalk_schema_id,
          CAST(TRY_TO_NUMERIC(auftraggeber_id) AS VARCHAR (10)) AS auftraggeber_id -- wegen IWT gecastet
          ,
          storno_fg,
          dat_erstellung,
          7
          FROM dbp_view.v_besch_faktura_1
          WHERE mandant_id = 1
          AND fakturaart_id not in ('ZIWU', 'ZIWV');