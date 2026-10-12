CREATE OR REPLACE VIEW idq_production_eks_calculation.steks_translation_package_1 (translationid, checkid, pkid,
translation_fieldid, crdate, moddate, cruser, moduser, description) AS SELECT translationid,
 checkid,
 pkid,
 translation_fieldid,
 crdate,
 moddate,
 cruser,
 moduser,
 description
FROM idq_production_eks.translation_int_1
WHERE translation_fieldid = 10;