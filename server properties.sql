select 'BuildClrVersion', serverproperty('BuildClrVersion')
union all
select 'Collation', serverproperty('Collation')
union all
select 'CollationID', serverproperty('CollationID')
union all
select 'ComparisonStyle', serverproperty('ComparisonStyle')
union all
select 'ComputerNamePhysicalNetBIOS', serverproperty('ComputerNamePhysicalNetBIOS')
union all
select 'Edition', serverproperty('Edition')
union all
select 'EditionID', serverproperty('EditionID')
union all
select 'EngineEdition', serverproperty('EngineEdition')
union all
select 'FilestreamConfiguredLevel', serverproperty('FilestreamConfiguredLevel')
union all
select 'FilestreamEffectiveLevel', serverproperty('FilestreamEffectiveLevel')
union all
select 'FilestreamShareName', serverproperty('FilestreamShareName')
union all
select 'HadrManagerStatus', serverproperty('HadrManagerStatus')
union all
select 'InstanceName', serverproperty('InstanceName')
union all
select 'IsAdvancedAnalyticsInstalled', serverproperty('IsAdvancedAnalyticsInstalled')
union all
select 'IsClustered', serverproperty('IsClustered')
union all
select 'IsFullTextInstalled', serverproperty('IsFullTextInstalled')
union all
select 'IsHadrEnabled', serverproperty('IsHadrEnabled')
union all
select 'IsIntegratedSecurityOnly', serverproperty('IsIntegratedSecurityOnly')
union all
select 'IsLocalDB', serverproperty('IsLocalDB')
union all
select 'IsPolybaseInstalled', serverproperty('IsPolybaseInstalled')
union all
select 'IsSingleUser', serverproperty('IsSingleUser')
union all
select 'IsXTPSupported', serverproperty('IsXTPSupported')
union all
select 'LCID', serverproperty('LCID')
union all
select 'LicenseType', serverproperty('LicenseType')
union all
select 'MachineName', serverproperty('MachineName')
union all
select 'NumLicenses', serverproperty('NumLicenses')
union all
select 'ProcessID', serverproperty('ProcessID')
union all
select 'ProductBuild', serverproperty('ProductBuild')
union all
select 'ProductBuildType', serverproperty('ProductBuildType')
union all
select 'ProductLevel', serverproperty('ProductLevel')
union all
select 'ProductMajorVersion', serverproperty('ProductMajorVersion')
union all
select 'ProductMinorVersion', serverproperty('ProductMinorVersion')
union all
select 'ProductUpdateLevel', serverproperty('ProductUpdateLevel')
union all
select 'ProductUpdateReference', serverproperty('ProductUpdateReference')
union all
select 'ProductVersion', serverproperty('ProductVersion')
union all
select 'ResourceLastUpdateDateTime', serverproperty('ResourceLastUpdateDateTime')
union all
select 'ResourceVersion', serverproperty('ResourceVersion')
union all
select 'ServerName', serverproperty('ServerName')
union all
select 'SqlCharSet', serverproperty('SqlCharSet')
union all
select 'SqlCharSetName', serverproperty('SqlCharSetName')
union all
select 'SqlSortOrder', serverproperty('SqlSortOrder')
union all
select 'SqlSortOrderName', serverproperty('SqlSortOrderName')
