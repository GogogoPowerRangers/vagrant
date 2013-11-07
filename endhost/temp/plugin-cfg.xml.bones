<?xml version="1.0" encoding="ISO-8859-1"?>

<Config ASDisableNagle="false" AcceptAllContent="false"
    IISDisableNagle="false" IgnoreDNSFailures="false"
    RefreshInterval="60" ResponseChunkSize="64">
  <Log LogLevel="Error" Name="/QIBM/UserData/WebASE51/ASE/
      default/logs/http_plugin.log"/>
  <Property Name="ESIEnable" Value="true"/>
  <Property Name="ESIMaxCacheSize" Value="1024"/>
  <Property Name="ESIInvalidationMonitor" Value="false"/>
  <VirtualHostGroup Name="default_host">
    <VirtualHost Name="*:13341"/>
    <VirtualHost Name="*:80"/>
  </VirtualHostGroup>
  <ServerCluster CloneSeparatorChange="false" LoadBalance="Round Robin"
      Name="server1_MYSYSTEM_default_Cluster" PostSizeLimit="-1"
      RemoveSpecialHeaders="true" RetryInterval="60">
    <Server ConnectTimeout="0" ExtendedHandshake="false"
        MaxConnections="-1" Name="MYSYSTEM_default_server1"
        WaitForContinue="false">
      <Transport Hostname="MYSYSTEM.RCHLAND.IBM.COM" Port="13341"
          Protocol="http"/>
      <Transport Hostname="MYSYSTEM.RCHLAND.IBM.COM" Port="13353"
          Protocol="https">
        <Property Name="keyring" Value="/QIBM/UserData/WebASE51/ASE/
            default/etc/plugin-key.kdb"/>
        <Property Name="stashfile" Value="/QIBM/UserData/WebASE51/ASE/
            default/etc/plugin-key.sth"/>
      </Transport>
    </Server>
      <PrimaryServers>
        <Server Name="MYSYSTEM_default_server1"/>
      </PrimaryServers>
  </ServerCluster>
  <UriGroup Name="default_host_server1_MYSYSTEM_default_Cluster_URIs">
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="/snoop/*"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="/hello"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="/hitcount"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="*.jsp"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="*.jsv"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="*.jsw"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="/j_security_check"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="/ibm_security_logout"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="/servlet/*"/>
    <Uri AffinityCookie="JSESSIONID" AffinityURLIdentifier="jsessionid"
        Name="/ivt/*"/>
  </UriGroup>
  <Route ServerCluster="server1_MYSYSTEM_default_Cluster"
      UriGroup="default_host_server1_MYSYSTEM_default_Cluster_URIs"
      VirtualHostGroup="default_host"/>
  <RequestMetrics armEnabled="false" newBehavior="false"
      rmEnabled="false" traceLevel="HOPS">
    <filters enable="false" type="URI">
      <filterValues enable="false" value="/servlet/snoop"/>
      <filterValues enable="false" value="/webapp/examples/HitCount"/>
    </filters>
    <filters enable="false" type="SOURCE_IP">
      <filterValues enable="false" value="255.255.255.255"/>
      <filterValues enable="false" value="254.254.254.254"/>
    </filters>
  </RequestMetrics>
</Config>
