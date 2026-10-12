CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_buchungsstatus_ker(IN KJ_KER_MO_ID FLOAT64, IN DAT_FI1 DATE, IN DAT_FI2 DATE, IN DAT_BS DATE)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''UPDATE dbp_data.l_buchungsstatus_ker SET  dat_fruehinfo1 = @DAT_FI1,  dat_fruehinfo2 = @DAT_FI2,  dat_buchungs_schluss = @DAT_BS WHERE kj_ker_mo_id = @KJ_KER_MO_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT_FI1) AS DAT_FI1,  FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT_FI2) AS DAT_FI2,  FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT_BS) AS DAT_BS,  KJ_KER_MO_ID AS KJ_KER_MO_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;

