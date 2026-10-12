CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_RECH_POS_WBNK_BRDK_1
       -- 01.12.2017 twie: NSR0041699 row_grund_id ist char
       (
       system_id
       ,mandant_id
       ,rech_beleg_id
       ,gj
       ,wbnk_planungs_kz
       ,row_grund_id

       )
       AS

          SELECT
          7,
          br.mandant_id,
          br.rech_beleg_id,
          br.gj,
          CASE WHEN row_grund_id IN ('117','124','125','126','129','133','135') THEN 'statistisch geplant'
          WHEN row_grund_id IN ('113','127','128','131','136','143','162') THEN 'ungeplant'
          WHEN row_grund_id IN ('146','150','152','154','163','165','174') THEN 'sonstige Erlöse'
          WHEN row_grund_id IN ('118','130','137','141','144','145','147','151','153','164','172','173','175') THEN 'Sachkosten'
          ELSE 'keine BNK'
          END AS wbnk_planungs_kz,
          COALESCE(brdk.row_grund_id,'0') AS row_grund_id

          from dbp_view.v_besch_rech_1  br
          LEFT OUTER join dbp_view.v_besch_rech_det_kont_1 brdk
          ON br.mandant_id = brdk.mandant_id
          AND br.rech_beleg_id = brdk.rech_beleg_id
          AND br.gj = brdk.gj


          WHERE br.mandant_id = 1
          group by 1,2,3,4,6,5;