CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.P_UPD_T_LIL_RPT_COMMENT

/*
#-------------------------------------------------------------------------------
# Comments:
#-------------------------------------------------------------------------------
*/

--COMMENT ON PROCEDURE p_lew_mart_analytics.n_sca_fill_assoc_receip_item_hierarchy 'Auxilary stored procedure which will make use of a view to retrieve results into a global temporary table';
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
(I_STORY_ID STRING
, I_DOC_ID STRING
, I_VERSION_ID STRING
, I_USER_NAME STRING
, I_CLIENT_ID FLOAT
, I_CLIENT_ID_MULTI STRING
, I_CLNT_RTL_ID FLOAT
, I_CLNT_RTL_ID_MULTI STRING
, I_RTL_BRAND_ID FLOAT
, I_RTL_BRAND_ID_MULTI STRING
, I_PER_TP_ID FLOAT
, I_PER_ID FLOAT
, I_LIFT_CAT_ID FLOAT
, I_LIFT_CAT_ID_MULTI STRING
, I_LIAM_PARNT_CLNT_CAT_ID CHAR(27)
, I_LIAM_CLNT_CAT_ID CHAR(27)
, I_PROM_ID_MULTI STRING
, I_MEAS_ID FLOAT
, I_MEAS_ID_MULTI STRING
, I_CURRENCY_ISO_CD CHAR(3)
, I_COMMENT_1 STRING
, I_COMMENT_2 STRING
, I_COMMENT_P STRING
, I_SHOW_REPORT_FG FLOAT
)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS CALLER
   AS
   $$
 	{
   var fetch = (count,rows,stmt) => (count && rows.next() && Array.apply(null,Array(stmt.getColumnCount())).map((_,i) => rows.getColumnValue(i + 1))) || [];
   /* header placed here for COMPILE FILE to succeed...
   #-------------------------------------------------------------------------------
   # Â© LIDL Stiftung & Co. KG - DWH / MIS
   #-------------------------------------------------------------------------------
   # Interface : DDL for procedure p_lew_mart_msi.p_lil_rpt_comment
   #-------------------------------------------------------------------------------
   # Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
   #-------------------------------------------------------------------------------
   # $Id: lew_mart_msi_p_upd_t_lil_rpt_comment.sql 6708 2018-01-18 10:21:29Z hwieber $
   # $Revision: 6708 $
   # $LastChangedBy: hwieber $
   # $LastChangedDate: 2018-01-18 11:21:29 +0100 (Do, 18 Jan 2018) $
   # $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_p_upd_t_lil_rpt_comment.sql $
   #-------------------------------------------------------------------------------
   # Subversion Infostamp END
   #-------------------------------------------------------------------------------
   # History:
   #  1.0  2017-06-07  Gernot Kunz      Initial Deployment PPM#228653 Patch 1360
   #-------------------------------------------------------------------------------
   */
   var V_MAX_CMT_UNIT_ID;
   var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT, INTO;
   var fixBind = function (arg) {
      arg = arg == undefined ? null : arg instanceof Date ? arg.toISOString() : arg;
      return arg;
   };
   var EXEC = function (stmt,binds,noCatch,catchFunction) {
      try {
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         ROW_COUNT = _RS.getRowCount();
         ACTIVITY_COUNT = _RS.getNumRowsAffected();
         if (INTO) return {
            INTO : function () {
               return INTO();
            }
         };
      } catch(error) {
         MESSAGE_TEXT = error.message;
         SQLCODE = error.code;
         SQLSTATE = error.state;
         var msg = `ERROR CODE: ${SQLCODE} SQLSTATE: ${SQLSTATE} MESSAGE: ${MESSAGE_TEXT}`;
         if (catchFunction) catchFunction(error);
         if (!noCatch && ERROR_HANDLERS) ERROR_HANDLERS(error); else throw new Error(msg);
      }
   };
   var INTO = function () {
      if (ROW_COUNT) return fetch(ROW_COUNT,_ROWS,_RS); else return [];
   };
   /* log procedure call (for support) */
   EXEC(`INSERT INTO p_lew_mart_msi.t_msi_lil_rpt_comment_log_1 (
story_id, doc_id, version_id, user_name, client_id, client_id_multi, clnt_rtl_id, clnt_rtl_id_multi, rtl_brand_id,
rtl_brand_id_multi, per_tp_id, per_id, lift_cat_id, lift_cat_id_multi, liam_parnt_clnt_cat_id, liam_clnt_cat_id,
prom_id_multi, meas_id,
meas_id_multi, currency_iso_cd,
comment_1, comment_2, comment_p, show_report_fg, mod_tmsp) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, Current_Timestamp(6))`,[I_STORY_ID,I_DOC_ID,I_VERSION_ID,I_USER_NAME,I_CLIENT_ID,I_CLIENT_ID_MULTI,I_CLNT_RTL_ID,I_CLNT_RTL_ID_MULTI,I_RTL_BRAND_ID,I_RTL_BRAND_ID_MULTI,I_PER_TP_ID,I_PER_ID,I_LIFT_CAT_ID,I_LIFT_CAT_ID_MULTI,I_LIAM_PARNT_CLNT_CAT_ID,I_LIAM_CLNT_CAT_ID,I_PROM_ID_MULTI,I_MEAS_ID,I_MEAS_ID_MULTI,I_CURRENCY_ISO_CD,I_COMMENT_1,I_COMMENT_2,I_COMMENT_P,I_SHOW_REPORT_FG]);
   EXEC(`
/* clean up old logs */
DELETE FROM p_lew_mart_msi.t_msi_lil_rpt_comment_log_1
WHERE mod_tmsp < Current_Timestamp(6) - INTERVAL '90 day'`,[]);
   /* update existing comments for all comment units with similar selection: and mark those comment units by reversing the sign */
   EXEC(`UPDATE p_lew_mart_msi.t_msi_lil_rpt_comment_1 SET comment_1 = ?
,comment_2 = ?
,comment_p = ?
,mod_tmsp = Current_Timestamp(6)
,cmt_unit_id = -cmt_unit_id
WHERE cmt_unit_id IN (SELECT
cmt.cmt_unit_id
FROM p_lew_mart_msi.t_msi_lil_rpt_comment_1 cmt
WHERE cmt.story_id = ?
  AND cmt.doc_id   = ?
  AND cmt.version_id = ?
  AND cmt.user_name = ?
  AND Coalesce(cmt.currency_iso_cd, '???') = Coalesce(?, '???')
  AND (
    Coalesce(cmt.client_id,   -9999)
   ,Coalesce(cmt.clnt_rtl_id, -9999)
   ,Coalesce(cmt.rtl_brand_id,-9999)
   ,Coalesce(cmt.per_tp_id,      -9999)
   ,Coalesce(cmt.per_id,      -9999)
   ,Coalesce(cmt.lift_cat_id, -9999)
   ,Coalesce(cmt.liam_parnt_clnt_cat_id, '????')
   ,Coalesce(cmt.liam_clnt_cat_id, '????')
   ,Coalesce(cmt.prom_id,     -9999)
   ,Coalesce(cmt.meas_id,     -9999)
  )  IN (SELECT
Coalesce(cl.client_id,   -9999),
Coalesce(cr.clnt_rtl_id, -9999),
Coalesce(rbr.rtl_brand_id,-9999),
Coalesce(?,   -9999),
Coalesce(?,     -9999),
Coalesce(liftc.lift_cat_id, -9999),
Coalesce(NullIf(?,''), '????'),
Coalesce(NullIf(?,''), '????'),
Coalesce(prom.prom_id,   -9999),
Coalesce(meas.meas_id,   -9999)
FROM  (SELECT
Cast(NullIf(clnt_sel.value, '') AS INTEGER) AS client_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),   ',')
) AS clnt_sel
GROUP BY 1
) AS cl

CROSS JOIN (SELECT
Cast(NullIf(clnt_rtl_sel.value, '') AS INTEGER) AS clnt_rtl_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),  ',')
) AS clnt_rtl_sel
GROUP BY 1
) AS cr

CROSS JOIN (SELECT
Cast(NullIf(rtl_brand_sel.value, '') AS INTEGER) AS rtl_brand_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),  ',')
) AS rtl_brand_sel
GROUP BY 1
) AS rbr

CROSS JOIN (SELECT
Cast(NullIf(lift_cat_sel.value, '') AS INTEGER) AS lift_cat_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),  ',')
) AS lift_cat_sel
GROUP BY 1
) AS liftc

CROSS JOIN (SELECT
Cast(NullIf(prom_sel.value, '') AS INTEGER) AS prom_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,''),  ',')
) AS prom_sel
GROUP BY 1
) AS prom

CROSS JOIN (SELECT
Cast(NullIf(meas_sel.value, '') AS INTEGER) AS meas_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),  ',')
) AS meas_sel
GROUP BY 1
) AS meas
))`,[I_COMMENT_1,I_COMMENT_2,I_COMMENT_P,I_STORY_ID,I_DOC_ID,I_VERSION_ID,I_USER_NAME,I_CURRENCY_ISO_CD,I_PER_TP_ID,I_PER_ID,I_LIAM_PARNT_CLNT_CAT_ID,I_LIAM_CLNT_CAT_ID,I_CLIENT_ID_MULTI,I_CLIENT_ID,I_CLNT_RTL_ID_MULTI,I_CLNT_RTL_ID,I_RTL_BRAND_ID_MULTI,I_RTL_BRAND_ID,I_LIFT_CAT_ID_MULTI,I_LIFT_CAT_ID,I_PROM_ID_MULTI,I_MEAS_ID_MULTI,I_MEAS_ID]);
   if (ACTIVITY_COUNT > 0) {
      /* find out the highest updated comment unit_1: this will become the new combined comment unit_1 */
      EXEC(`SELECT
Max(-cmt_unit_id)
FROM p_lew_mart_msi.t_msi_lil_rpt_comment_1 cmt
WHERE cmt.story_id = ?
  AND cmt.doc_id   = ?
  AND cmt.version_id = ?
  AND cmt.user_name = ?
  AND Coalesce(cmt.currency_iso_cd, '???') = Coalesce(?, '???')
  AND cmt.cmt_unit_id < 0`,[I_STORY_ID,I_DOC_ID,I_VERSION_ID,I_USER_NAME,I_CURRENCY_ISO_CD]);
      [V_MAX_CMT_UNIT_ID] = INTO();
      /* all updated comment units are set to the new combined comment unit_1: unifying them into one unit_1 */
      EXEC(`UPDATE p_lew_mart_msi.t_msi_lil_rpt_comment_1 AS cmt SET cmt.cmt_unit_id = ?
WHERE cmt.story_id = ?
  AND cmt.doc_id   = ?
  AND cmt.version_id = ?
  AND cmt.user_name = ?
  AND Coalesce(cmt.currency_iso_cd, '???') = Coalesce(?, '???')
  AND cmt.cmt_unit_id < 0`,[V_MAX_CMT_UNIT_ID,I_STORY_ID,I_DOC_ID,I_VERSION_ID,I_USER_NAME,I_CURRENCY_ISO_CD]);
   }
   /* insert comment records not already present: use new combined comment unit_1, if one is known, else create a new one */
   EXEC(`INSERT INTO p_lew_mart_msi.t_msi_lil_rpt_comment_1 (
story_id
,doc_id
,version_id
,user_name
,client_id
,clnt_rtl_id
,rtl_brand_id
,per_tp_id
,per_id
,lift_cat_id
,liam_parnt_clnt_cat_id
,liam_clnt_cat_id
,prom_id
,meas_id
,currency_iso_cd
,comment_1
,comment_2
,comment_p
,show_report_fg
,cmt_unit_id
,mod_tmsp)SELECT
?,
?,
?,
?,
cl.client_id,
cr.clnt_rtl_id,
rbr.rtl_brand_id,
?,
?,
liftc.lift_cat_id,
NullIf(?,''),
NullIf(?,''),
prom.prom_id,
meas.meas_id,
?,
?,
?,
?,
?,
Coalesce(?, mxuid.cmt_unit_id + 1),
Current_Timestamp
FROM (SELECT
Cast(NullIf(clnt_sel.value, '') AS INTEGER) AS client_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),   ',')
) AS clnt_sel
GROUP BY 1
) AS cl

CROSS JOIN (SELECT
Cast(NullIf(clnt_rtl_sel.value, '') AS INTEGER) AS clnt_rtl_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),  ',')
) AS clnt_rtl_sel
GROUP BY 1
) AS cr

CROSS JOIN (SELECT
Cast(NullIf(rtl_brand_sel.value, '') AS INTEGER) AS rtl_brand_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),  ',')
) AS rtl_brand_sel
GROUP BY 1
) AS rbr

CROSS JOIN (SELECT
Cast(NullIf(lift_cat_sel.value, '') AS INTEGER) AS lift_cat_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),  ',')
) AS lift_cat_sel
GROUP BY 1
) AS liftc

CROSS JOIN (SELECT
Cast(NullIf(prom_sel.value, '') AS INTEGER) AS prom_id
FROM TABLE (
StrTok_Split_To_Table (
  Coalesce(?,''),  ',')
) AS prom_sel
GROUP BY 1
) AS prom

CROSS JOIN (SELECT
Cast(NullIf(meas_sel.value, '') AS INTEGER) AS meas_id
FROM TABLE (
StrTok_Split_To_Table (Coalesce(?,'')||','||Coalesce(Cast(? AS VARCHAR(32)),''),  ',')
) AS meas_sel
GROUP BY 1
) AS meas

CROSS JOIN (SELECT
Coalesce(Max(cmt_unit_id),0) AS cmt_unit_id
FROM p_lew_mart_msi.t_msi_lil_rpt_comment_1
 ) AS mxuid
WHERE NOT EXISTS (SELECT
NULL
FROM p_lew_mart_msi.t_msi_lil_rpt_comment_1 cmc
WHERE cmc.story_id = ?
  AND cmc.doc_id = ?
  AND cmc.version_id = ?
  AND cmc.user_name = ?
  AND Coalesce(cmc.client_id, -9999) = Coalesce(cl.client_id, -9999)
  AND Coalesce(cmc.clnt_rtl_id, -9999) = Coalesce(cr.clnt_rtl_id, -9999)
  AND Coalesce(cmc.rtl_brand_id, -9999) = Coalesce(rbr.rtl_brand_id, -9999)
  AND Coalesce(cmc.per_tp_id, -9999) = Coalesce(?, -9999)
  AND Coalesce(cmc.per_id, -9999) = Coalesce(?, -9999)
  AND Coalesce(cmc.lift_cat_id,  -9999) = Coalesce(liftc.lift_cat_id, -9999)
  AND Coalesce(cmc.liam_parnt_clnt_cat_id, '????') = Coalesce(NullIf(?,''), '????')
  AND Coalesce(cmc.liam_clnt_cat_id, '????') = Coalesce(NullIf(?,''), '????')
  AND Coalesce(cmc.prom_id, -9999) = Coalesce(prom.prom_id, -9999)
  AND Coalesce(cmc.meas_id, -9999) = Coalesce(meas.meas_id, -9999)
  AND Coalesce(cmc.currency_iso_cd, '???') = Coalesce(?, '???')
)`,[I_STORY_ID,I_DOC_ID,I_VERSION_ID,I_USER_NAME,I_PER_TP_ID,I_PER_ID,I_LIAM_PARNT_CLNT_CAT_ID,I_LIAM_CLNT_CAT_ID,I_CURRENCY_ISO_CD,I_COMMENT_1,I_COMMENT_2,I_COMMENT_P,I_SHOW_REPORT_FG,V_MAX_CMT_UNIT_ID,I_CLIENT_ID_MULTI,I_CLIENT_ID,I_CLNT_RTL_ID_MULTI,I_CLNT_RTL_ID,I_RTL_BRAND_ID_MULTI,I_RTL_BRAND_ID,I_LIFT_CAT_ID_MULTI,I_LIFT_CAT_ID,I_PROM_ID_MULTI,I_MEAS_ID_MULTI,I_MEAS_ID,I_STORY_ID,I_DOC_ID,I_VERSION_ID,I_USER_NAME,I_PER_TP_ID,I_PER_ID,I_LIAM_PARNT_CLNT_CAT_ID,I_LIAM_CLNT_CAT_ID,I_CURRENCY_ISO_CD]);
}

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute(); 
$$
;

