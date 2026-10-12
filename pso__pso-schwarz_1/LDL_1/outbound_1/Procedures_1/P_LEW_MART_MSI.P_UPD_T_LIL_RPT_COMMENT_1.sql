CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.p_upd_t_lil_rpt_comment`(
  I_STORY_ID STRING,
  I_DOC_ID STRING,
  I_VERSION_ID STRING,
  I_USER_NAME STRING,
  I_CLIENT_ID FLOAT64,
  I_CLIENT_ID_MULTI STRING,
  I_CLNT_RTL_ID FLOAT64,
  I_CLNT_RTL_ID_MULTI STRING,
  I_RTL_BRAND_ID FLOAT64,
  I_RTL_BRAND_ID_MULTI STRING,
  I_PER_TP_ID FLOAT64,
  I_PER_ID FLOAT64,
  I_LIFT_CAT_ID FLOAT64,
  I_LIFT_CAT_ID_MULTI STRING,
  I_LIAM_PARNT_CLNT_CAT_ID STRING,
  I_LIAM_CLNT_CAT_ID STRING,
  I_PROM_ID_MULTI STRING,
  I_MEAS_ID FLOAT64,
  I_MEAS_ID_MULTI STRING,
  I_CURRENCY_ISO_CD STRING,
  I_COMMENT_1 STRING,
  I_COMMENT_2 STRING,
  I_COMMENT_P STRING,
  I_SHOW_REPORT_FG FLOAT64
)


BEGIN
/*
#-------------------------------------------------------------------------------
# Comments:
#-------------------------------------------------------------------------------
*/

--Auxilary stored procedure which will make use of a view to retrieve results into a global temporary table
--------------------------------------------------------------------------------

/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.p_upd_t_lil_rpt_comment
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_msi_p_upd_t_lil_rpt_comment.sql 6708 2018-01-18 10:21:29Z hwieber $
# $Revision: 6708 $
# $LastChangedBy: hwieber $
# $LastChangedDate: 2018-01-18 11:21:29 +0100 (Do, 18 Jan 2018) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_p_upd_t_lil_rpt_comment.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2018    Michael Ueding           Initial
#----------------------------------------------------------------------------
*/


  DECLARE V_MAX_CMT_UNIT_ID INT64;

  /* log procedure call (for support) */
  EXECUTE IMMEDIATE """
    INSERT INTO `p_lew_mart_msi.t_msi_lil_rpt_comment_log_1` (
      story_id, doc_id, version_id, user_name, client_id, client_id_multi, clnt_rtl_id, clnt_rtl_id_multi, rtl_brand_id,
      rtl_brand_id_multi, per_tp_id, per_id, lift_cat_id, lift_cat_id_multi, liam_parnt_clnt_cat_id, liam_clnt_cat_id,
      prom_id_multi, meas_id, meas_id_multi, currency_iso_cd, comment_1, comment_2, comment_p, show_report_fg, mod_tmsp
    ) VALUES (
      @story_id, @doc_id, @version_id, @user_name, @client_id, @client_id_multi, @clnt_rtl_id, @clnt_rtl_id_multi, @rtl_brand_id,
      @rtl_brand_id_multi, @per_tp_id, @per_id, @lift_cat_id, @lift_cat_id_multi, @liam_parnt_clnt_cat_id, @liam_clnt_cat_id,
      @prom_id_multi, @meas_id, @meas_id_multi, @currency_iso_cd, @comment_1, @comment_2, @comment_p, @show_report_fg, CAST(CURRENT_TIMESTAMP() AS DATETIME)
    )
  """ USING 
    I_STORY_ID AS story_id, I_DOC_ID AS doc_id, I_VERSION_ID AS version_id, I_USER_NAME AS user_name, 
    CAST(I_CLIENT_ID AS INT64) AS client_id, I_CLIENT_ID_MULTI AS client_id_multi, CAST(I_CLNT_RTL_ID AS INT64) AS clnt_rtl_id, 
    I_CLNT_RTL_ID_MULTI AS clnt_rtl_id_multi, CAST(I_RTL_BRAND_ID AS INT64) AS rtl_brand_id, I_RTL_BRAND_ID_MULTI AS rtl_brand_id_multi, 
    CAST(I_PER_TP_ID AS INT64) AS per_tp_id, CAST(I_PER_ID AS INT64) AS per_id, CAST(I_LIFT_CAT_ID AS INT64) AS lift_cat_id, I_LIFT_CAT_ID_MULTI AS lift_cat_id_multi, 
    I_LIAM_PARNT_CLNT_CAT_ID AS liam_parnt_clnt_cat_id, I_LIAM_CLNT_CAT_ID AS liam_clnt_cat_id, 
    I_PROM_ID_MULTI AS prom_id_multi, CAST(I_MEAS_ID AS INT64) AS meas_id, I_MEAS_ID_MULTI AS meas_id_multi, 
    I_CURRENCY_ISO_CD AS currency_iso_cd, I_COMMENT_1 AS comment_1, I_COMMENT_2 AS comment_2, 
    I_COMMENT_P AS comment_p, CAST(I_SHOW_REPORT_FG AS INT64) AS show_report_fg;

  /* clean up old logs */
  EXECUTE IMMEDIATE """
    DELETE FROM `p_lew_mart_msi.t_msi_lil_rpt_comment_log_1`
    WHERE mod_tmsp < CAST(TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY) AS DATETIME)
  """;

  /* update existing comments for all comment units with similar selection: and mark those comment units by reversing the sign */
  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_msi_lil_rpt_comment_1` 
    SET comment_1 = @comment_1, 
        comment_2 = @comment_2, 
        comment_p = @comment_p, 
        mod_tmsp = CAST(CURRENT_TIMESTAMP() AS DATETIME), 
        cmt_unit_id = -cmt_unit_id
    WHERE cmt_unit_id IN (
      SELECT cmt.cmt_unit_id
      FROM `p_lew_mart_msi.t_msi_lil_rpt_comment_1` cmt
      WHERE cmt.story_id = @story_id
        AND cmt.doc_id   = @doc_id
        AND cmt.version_id = @version_id
        AND cmt.user_name = @user_name
        AND COALESCE(cmt.currency_iso_cd, '???') = COALESCE(@currency_iso_cd, '???')
        AND STRUCT(
          COALESCE(cmt.client_id,   -9999),
          COALESCE(cmt.clnt_rtl_id, -9999),
          COALESCE(cmt.rtl_brand_id,-9999),
          COALESCE(cmt.per_tp_id,   -9999),
          COALESCE(cmt.per_id,      -9999),
          COALESCE(cmt.lift_cat_id, -9999),
          COALESCE(cmt.liam_parnt_clnt_cat_id, '????'),
          COALESCE(cmt.liam_clnt_cat_id, '????'),
          COALESCE(cmt.prom_id,     -9999),
          COALESCE(cmt.meas_id,     -9999)
        ) IN (
          SELECT STRUCT(
            COALESCE(cl.client_id,   -9999),
            COALESCE(cr.clnt_rtl_id, -9999),
            COALESCE(rbr.rtl_brand_id,-9999),
            COALESCE(CAST(@per_tp_id AS INT64), -9999),
            COALESCE(CAST(@per_id AS INT64), -9999),
            COALESCE(liftc.lift_cat_id, -9999),
            COALESCE(NULLIF(@liam_parnt_clnt_cat_id,''), '????'),
            COALESCE(NULLIF(@liam_clnt_cat_id,''), '????'),
            COALESCE(prom.prom_id,   -9999),
            COALESCE(meas.meas_id,   -9999)
          )
          FROM (SELECT CAST(NULLIF(clnt_sel, '') AS INT64) AS client_id FROM UNNEST(SPLIT(COALESCE(@client_id_multi,'')||','||COALESCE(CAST(@client_id AS STRING),''), ',')) AS clnt_sel GROUP BY 1) AS cl
          CROSS JOIN (SELECT CAST(NULLIF(clnt_rtl_sel, '') AS INT64) AS clnt_rtl_id FROM UNNEST(SPLIT(COALESCE(@clnt_rtl_id_multi,'')||','||COALESCE(CAST(@clnt_rtl_id AS STRING),''), ',')) AS clnt_rtl_sel GROUP BY 1) AS cr
          CROSS JOIN (SELECT CAST(NULLIF(rtl_brand_sel, '') AS INT64) AS rtl_brand_id FROM UNNEST(SPLIT(COALESCE(@rtl_brand_id_multi,'')||','||COALESCE(CAST(@rtl_brand_id AS STRING),''), ',')) AS rtl_brand_sel GROUP BY 1) AS rbr
          CROSS JOIN (SELECT CAST(NULLIF(lift_cat_sel, '') AS INT64) AS lift_cat_id FROM UNNEST(SPLIT(COALESCE(@lift_cat_id_multi,'')||','||COALESCE(CAST(@lift_cat_id AS STRING),''), ',')) AS lift_cat_sel GROUP BY 1) AS liftc
          CROSS JOIN (SELECT CAST(NULLIF(prom_sel, '') AS INT64) AS prom_id FROM UNNEST(SPLIT(COALESCE(@prom_id_multi,''), ',')) AS prom_sel GROUP BY 1) AS prom
          CROSS JOIN (SELECT CAST(NULLIF(meas_sel, '') AS INT64) AS meas_id FROM UNNEST(SPLIT(COALESCE(@meas_id_multi,'')||','||COALESCE(CAST(@meas_id AS STRING),''), ',')) AS meas_sel GROUP BY 1) AS meas
        )
    )
  """ USING 
    I_COMMENT_1 AS comment_1, I_COMMENT_2 AS comment_2, I_COMMENT_P AS comment_p, I_STORY_ID AS story_id, 
    I_DOC_ID AS doc_id, I_VERSION_ID AS version_id, I_USER_NAME AS user_name, I_CURRENCY_ISO_CD AS currency_iso_cd, 
    I_PER_TP_ID AS per_tp_id, I_PER_ID AS per_id, I_LIAM_PARNT_CLNT_CAT_ID AS liam_parnt_clnt_cat_id, 
    I_LIAM_CLNT_CAT_ID AS liam_clnt_cat_id, I_CLIENT_ID_MULTI AS client_id_multi, I_CLIENT_ID AS client_id, 
    I_CLNT_RTL_ID_MULTI AS clnt_rtl_id_multi, I_CLNT_RTL_ID AS clnt_rtl_id, I_RTL_BRAND_ID_MULTI AS rtl_brand_id_multi, 
    I_RTL_BRAND_ID AS rtl_brand_id, I_LIFT_CAT_ID_MULTI AS lift_cat_id_multi, I_LIFT_CAT_ID AS lift_cat_id, 
    I_PROM_ID_MULTI AS prom_id_multi, I_MEAS_ID_MULTI AS meas_id_multi, I_MEAS_ID AS meas_id;

  IF @@row_count > 0 THEN
    /* find out the highest updated comment unit_1: this will become the new combined comment unit_1 */
    EXECUTE IMMEDIATE """
      SELECT MAX(-cmt_unit_id)
      FROM `p_lew_mart_msi.t_msi_lil_rpt_comment_1` cmt
      WHERE cmt.story_id = @story_id
        AND cmt.doc_id   = @doc_id
        AND cmt.version_id = @version_id
        AND cmt.user_name = @user_name
        AND COALESCE(cmt.currency_iso_cd, '???') = COALESCE(@currency_iso_cd, '???')
        AND cmt.cmt_unit_id < 0
    """ INTO V_MAX_CMT_UNIT_ID USING I_STORY_ID AS story_id, I_DOC_ID AS doc_id, I_VERSION_ID AS version_id, I_USER_NAME AS user_name, I_CURRENCY_ISO_CD AS currency_iso_cd;

    /* all updated comment units are set to the new combined comment unit_1: unifying them into one unit_1 */
    EXECUTE IMMEDIATE """
      UPDATE `p_lew_mart_msi.t_msi_lil_rpt_comment_1` AS cmt 
      SET cmt.cmt_unit_id = @max_cmt_id
      WHERE cmt.story_id = @story_id
        AND cmt.doc_id   = @doc_id
        AND cmt.version_id = @version_id
        AND cmt.user_name = @user_name
        AND COALESCE(cmt.currency_iso_cd, '???') = COALESCE(@currency_iso_cd, '???')
        AND cmt.cmt_unit_id < 0
    """ USING V_MAX_CMT_UNIT_ID AS max_cmt_id, I_STORY_ID AS story_id, I_DOC_ID AS doc_id, I_VERSION_ID AS version_id, I_USER_NAME AS user_name, I_CURRENCY_ISO_CD AS currency_iso_cd;
  END IF;

  /* insert comment records not already present: use new combined comment unit_1, if one is known, else create a new one */
  EXECUTE IMMEDIATE """
    INSERT INTO `p_lew_mart_msi.t_msi_lil_rpt_comment_1` (
      story_id, doc_id, version_id, user_name, client_id, clnt_rtl_id, rtl_brand_id, per_tp_id, per_id, lift_cat_id,
      liam_parnt_clnt_cat_id, liam_clnt_cat_id, prom_id, meas_id, currency_iso_cd, comment_1, comment_2, comment_p, show_report_fg, cmt_unit_id, mod_tmsp
    )
    SELECT
      @story_id, @doc_id, @version_id, @user_name, cl.client_id, cr.clnt_rtl_id, rbr.rtl_brand_id, @per_tp_id, @per_id, liftc.lift_cat_id,
      NULLIF(@liam_parnt_clnt_cat_id,''), NULLIF(@liam_clnt_cat_id,''), prom.prom_id, meas.meas_id, @currency_iso_cd, @comment_1, @comment_2, @comment_p, @show_report_fg,
      COALESCE(@max_cmt_id, mxuid.cmt_unit_id + 1), CAST(CURRENT_TIMESTAMP() AS DATETIME)
    FROM (SELECT CAST(NULLIF(clnt_sel, '') AS INT64) AS client_id FROM UNNEST(SPLIT(COALESCE(@client_id_multi,'')||','||COALESCE(CAST(@client_id AS STRING),''), ',')) AS clnt_sel GROUP BY 1) AS cl
    CROSS JOIN (SELECT CAST(NULLIF(clnt_rtl_sel, '') AS INT64) AS clnt_rtl_id FROM UNNEST(SPLIT(COALESCE(@clnt_rtl_id_multi,'')||','||COALESCE(CAST(@clnt_rtl_id AS STRING),''), ',')) AS clnt_rtl_sel GROUP BY 1) AS cr
    CROSS JOIN (SELECT CAST(NULLIF(rtl_brand_sel, '') AS INT64) AS rtl_brand_id FROM UNNEST(SPLIT(COALESCE(@rtl_brand_id_multi,'')||','||COALESCE(CAST(@rtl_brand_id AS STRING),''), ',')) AS rtl_brand_sel GROUP BY 1) AS rbr
    CROSS JOIN (SELECT CAST(NULLIF(lift_cat_sel, '') AS INT64) AS lift_cat_id FROM UNNEST(SPLIT(COALESCE(@lift_cat_id_multi,'')||','||COALESCE(CAST(@lift_cat_id AS STRING),''), ',')) AS lift_cat_sel GROUP BY 1) AS liftc
    CROSS JOIN (SELECT CAST(NULLIF(prom_sel, '') AS INT64) AS prom_id FROM UNNEST(SPLIT(COALESCE(@prom_id_multi,''), ',')) AS prom_sel GROUP BY 1) AS prom
    CROSS JOIN (SELECT CAST(NULLIF(meas_sel, '') AS INT64) AS meas_id FROM UNNEST(SPLIT(COALESCE(@meas_id_multi,'')||','||COALESCE(CAST(@meas_id AS STRING),''), ',')) AS meas_sel GROUP BY 1) AS meas
    CROSS JOIN (SELECT COALESCE(MAX(cmt_unit_id),0) AS cmt_unit_id FROM `p_lew_mart_msi.t_msi_lil_rpt_comment_1`) AS mxuid
    WHERE NOT EXISTS (
      SELECT 1
      FROM `p_lew_mart_msi.t_msi_lil_rpt_comment_1` cmc
      WHERE cmc.story_id = @story_id
        AND cmc.doc_id = @doc_id
        AND cmc.version_id = @version_id
        AND cmc.user_name = @user_name
        AND COALESCE(cmc.client_id, -9999) = COALESCE(cl.client_id, -9999)
        AND COALESCE(cmc.clnt_rtl_id, -9999) = COALESCE(cr.clnt_rtl_id, -9999)
        AND COALESCE(cmc.rtl_brand_id, -9999) = COALESCE(rbr.rtl_brand_id, -9999)
        AND COALESCE(cmc.per_tp_id, -9999) = COALESCE(@per_tp_id, -9999)
        AND COALESCE(cmc.per_id, -9999) = COALESCE(@per_id, -9999)
        AND COALESCE(cmc.lift_cat_id,  -9999) = COALESCE(liftc.lift_cat_id, -9999)
        AND COALESCE(cmc.liam_parnt_clnt_cat_id, '????') = COALESCE(NULLIF(@liam_parnt_clnt_cat_id,''), '????')
        AND COALESCE(cmc.liam_clnt_cat_id, '????') = COALESCE(NULLIF(@liam_clnt_cat_id,''), '????')
        AND COALESCE(cmc.prom_id, -9999) = COALESCE(prom.prom_id, -9999)
        AND COALESCE(cmc.meas_id, -9999) = COALESCE(meas.meas_id, -9999)
        AND COALESCE(cmc.currency_iso_cd, '???') = COALESCE(@currency_iso_cd, '???')
    )
  """ USING 
    I_STORY_ID AS story_id, I_DOC_ID AS doc_id, I_VERSION_ID AS version_id, I_USER_NAME AS user_name, 
    CAST(I_PER_TP_ID AS INT64) AS per_tp_id, CAST(I_PER_ID AS INT64) AS per_id, I_LIAM_PARNT_CLNT_CAT_ID AS liam_parnt_clnt_cat_id, 
    I_LIAM_CLNT_CAT_ID AS liam_clnt_cat_id, I_CURRENCY_ISO_CD AS currency_iso_cd, I_COMMENT_1 AS comment_1, 
    I_COMMENT_2 AS comment_2, I_COMMENT_P AS comment_p, CAST(I_SHOW_REPORT_FG AS INT64) AS show_report_fg, 
    V_MAX_CMT_UNIT_ID AS max_cmt_id, I_CLIENT_ID_MULTI AS client_id_multi, I_CLIENT_ID AS client_id, 
    I_CLNT_RTL_ID_MULTI AS clnt_rtl_id_multi, I_CLNT_RTL_ID AS clnt_rtl_id, I_RTL_BRAND_ID_MULTI AS rtl_brand_id_multi, 
    I_RTL_BRAND_ID AS rtl_brand_id, I_LIFT_CAT_ID_MULTI AS lift_cat_id_multi, I_LIFT_CAT_ID AS lift_cat_id, 
    I_PROM_ID_MULTI AS prom_id_multi, I_MEAS_ID_MULTI AS meas_id_multi, I_MEAS_ID AS meas_id;

    EXCEPTION WHEN ERROR THEN
    RAISE USING MESSAGE = 'MESSAGE: ' || @@error.message;
END;