<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:tei="http://www.tei-c.org/ns/1.0"
xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:preserve-space elements="tei:p tei:s tei:hi tei:stamp"/>
	<xsl:strip-space elements="*"/>
	<!-- Struttura del file -->
	<xsl:template match="/tei:TEI">
		<html>
			<head>
				<title>Progetto per l'esame di codifica di testi.</title>
				<link href="LL1.21.css" rel="stylesheet" type="text/css"/>
				<script src="LL1.21.js"></script>
			</head>
			<body>
				<div id="header" class="container">
					<h1>Progetto per l'esame di codifica di testi: lettera LL1.21 di Vincenzo Bellini.</h1>
					<!-- CTF: applico un template per l'elemento titleStmt -->
					<xsl:apply-templates select="tei:teiHeader//tei:titleStmt"/>
					<!-- CTF: applico un template per l'elementotei:editionStmt -->  
					<xsl:apply-templates select="tei:teiHeader//tei:editionStmt"/>
					<!-- CTF: applico un template per l'elemento publicationStmt -->
					<xsl:apply-templates select="tei:teiHeader//tei:publicationStmt"/>
					<!-- CTF: applico un template per l'elemento msDesc -->
					<xsl:apply-templates select="tei:teiHeader//tei:msDesc"/>
					<!-- CTF: applico un template per l'elemento profileDesc -->
					<xsl:apply-templates select="tei:teiHeader/tei:profileDesc"/>
				</div>
				<!-- CTF:crea un blocco visual dove ci stanno le scansioni delle pagine con le frecce, il testo e l'appendice.-->
				<div id="blocco-visual">
					<div id="flexbox">
						<div id="scansioni">
							<h1>
								<img id="arrowb" src="arrow.png" onclick="scorri(this)"/> 
								Pagine della lettera
								<img id="arrowf" src="arrow.png" onclick="scorri(this)"/>
							</h1>
							<xsl:apply-templates select="tei:facsimile"/>
						</div>
						<div id="testo">
							<h1>Testo</h1>
							<xsl:apply-templates select="tei:text/tei:body"/> 
						</div>
					</div>
				</div>
				<div id="appendici" class="container">
					<h1>Appendici</h1>
					<xsl:apply-templates select="tei:text/tei:back//tei:div[@type='bibliography']"/>
				</div>
			</body>
		</html>
	</xsl:template>
    <!-- CTF:creo un'associazione tra il template con un elemento del documento xml-->
	<xsl:template match="tei:titleStmt">
		<h2><xsl:value-of select="tei:title"/></h2>
		<p>
			<b>Autore</b>: <a onclick="linkaNota(this)">
                <xsl:value-of select="tei:author"/>
            </a>
		</p>
		<xsl:apply-templates select="tei:respStmt"/>
	</xsl:template>
	<!-- CTF:creo un'associazione tra il template con un elemento del documento xml-->
	<xsl:template match="tei:editionStmt">
		<h2><xsl:value-of select="tei:edition"/></h2>
		<xsl:apply-templates select="tei:respStmt"/>
	</xsl:template>
	<!-- CTF:creo un'associazione tra il template con un elemento del documento xml-->
	<xsl:template match="tei:publicationStmt">
		<h2>Pubblicazione</h2>
		<p>
			<xsl:value-of select="tei:publisher"/>, 
			<xsl:value-of select="tei:pubPlace"/>, 
			<a>
				<xsl:attribute name="href"><xsl:value-of select="tei:availability/tei:licence/@target"/></xsl:attribute>
				<xsl:value-of select="tei:availability/tei:licence"/>
			</a>, 
			<xsl:value-of select="tei:date"/>
		</p>
	</xsl:template>
	<!-- CTF:creo un'associazione tra il template con un elemento del documento xml-->
	<xsl:template match="tei:msDesc">
		<div id="desc">
			<h2>
				Descrizione della lettera LL1.21.
				<a class="super" onclick="linkaNota(this)"> 
					<xsl:attribute name="href"><xsl:value-of select="../tei:bibl/@source"/></xsl:attribute>
					<xsl:attribute name="title">pp. <xsl:value-of select="../tei:bibl/tei:citedRange"/></xsl:attribute>fonte
				</a>
			</h2>
			<!--CTF:Ho creato un bottone che mostra e chiude le informazioni.-->
			<h3 onclick="mostraNota(this)" style="cursor: pointer">Identificatore<xsl:text>&#32;&#10133;</xsl:text></h3>
			<div style="display: none">
				<p><b>Paese e città</b>: <xsl:value-of select="tei:msIdentifier/tei:settlement"/>, <xsl:value-of select="tei:msIdentifier/tei:country"/></p>
				<p>
					<b>Museo</b>: 
					<a>
						<xsl:attribute name="href"><xsl:value-of select="tei:msIdentifier/tei:repository/@ref"/></xsl:attribute>
						<xsl:value-of select="tei:msIdentifier/tei:repository"/>
					</a>
				</p>
				<p><b>Numero di registrazione</b>: <xsl:value-of select="tei:msIdentifier/tei:idno"/></p>
				<p><b>Collocazione</b>: <xsl:value-of select="tei:msIdentifier/tei:altIdentifier/tei:idno"/></p>
			</div>
			<h3 onclick="mostraNota(this)" style="cursor: pointer">Contenuti<xsl:text>&#32;&#10133;</xsl:text></h3>
			<div style="display: none">
				<p>
					<b>Autore</b>: 
					<a onclick="linkaNota(this)">
						<xsl:attribute name="href"><xsl:value-of select="tei:msContents//tei:author/@ref"/></xsl:attribute>
						<xsl:value-of select="tei:msContents//tei:author"/>
					</a>
				</p>
				<p><b>Titolo</b>: <xsl:apply-templates select="tei:msContents//tei:title"/></p>
				<p><b>Lingua usata</b>: <xsl:value-of select="tei:msContents//tei:textLang"/></p>
				<p><b>Nota</b>: <xsl:apply-templates select="tei:msContents//tei:note"/></p>
			</div>
			<h3 onclick="mostraNota(this)" style="cursor: pointer">Descrizione fisica della lettera:<xsl:text>&#32;&#10133;</xsl:text></h3>
			<div style="display: none">
				<p><b>Materiale</b>: <xsl:value-of select="tei:physDesc//tei:material"/></p>
				<p><b>Caratteristiche</b>: <xsl:value-of select="tei:physDesc//tei:support/tei:p"/></p>
				<p><b>Numero di fogli</b>: <xsl:value-of select="tei:physDesc//tei:measure"/></p>
				<p><b>Altezza</b>: <xsl:value-of select="tei:physDesc//tei:height"/> <xsl:value-of select="tei:physDesc//tei:dimensions/@unit"/></p>
				<p><b>Larghezza</b>: <xsl:value-of select="tei:physDesc//tei:width"/> <xsl:value-of select="tei:physDesc//tei:dimensions/@unit"/></p>
				<p><b>Struttura</b>: <xsl:value-of select="tei:physDesc//tei:foliation"/></p>
				<p><b>Condizioni</b>: <xsl:value-of select="tei:physDesc//tei:condition/tei:p"/></p>
			</div>
			<h4>Annotazioni:</h4>
			<ol>
				<xsl:for-each select="tei:physDesc//tei:handNote">
					<li>
						<xsl:if test="@xml:id">
							<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
						</xsl:if>
						<xsl:value-of select="tei:p"/>
					</li>
				</xsl:for-each>
			</ol>
			<h3>Catalogazione:</h3>
			<div>
				<p><xsl:value-of select="tei:additional//tei:note"/></p>
			</div>
		</div>
	</xsl:template>
	<!-- CTF:creo un'associazione tra il template con un elemento del documento xml-->
	<xsl:template match="tei:profileDesc">
		<!--CTF:creo un cursore-->
		<h2 onclick="mostraNota(this)" style="cursor: pointer">Altre informazioni della lettera:<xsl:text>&#32;&#10133;</xsl:text></h2>
		<div style="display: none">
			<xsl:for-each select="tei:correspDesc/tei:correspAction">
				<h3>
					<xsl:choose>
						<xsl:when test="@type='sent'">Mittente:</xsl:when>
						<xsl:otherwise>Destinatario:</xsl:otherwise>
					</xsl:choose>
				</h3>
				<p>
				Nome/titolo:
					<xsl:apply-templates select="tei:persName"/>, luogo:
					<xsl:apply-templates select="tei:placeName"/>, data:
					<xsl:choose>
						<xsl:when test="tei:date/text()='unknown'">data sconosciuta</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="tei:date"/>
						</xsl:otherwise>
					</xsl:choose></p>
			</xsl:for-each>
			<h3>Contesto:</h3>
			<p><xsl:apply-templates select="tei:correspDesc//tei:p"/></p>
			<h3>Tipologia del testo:</h3>
			<p>
				<xsl:value-of select="tei:textClass//tei:term"/>
				(<a>
					<xsl:attribute name="href"><xsl:value-of select="tei:textClass/tei:keywords/@scheme"/></xsl:attribute>
					<xsl:value-of select="tei:textClass/tei:keywords/@scheme"/>
				</a>)
				<a class="super">
					<xsl:attribute name="href"><xsl:value-of select="tei:textClass//tei:term/@resp"/></xsl:attribute>fonte
				</a>
			</p>
			<h3>Lingue:</h3>
			<p>
				<xsl:for-each select="tei:langUsage/tei:language">
					<xsl:value-of select="."/>;
				</xsl:for-each>
			</p>
		</div>
	</xsl:template>
	<!-- CTF: creo una parte grafica per l'elemento tei:surface -->
	<xsl:template match="tei:surface">
		<div class="img">
			<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
			<img><xsl:attribute name="src"><xsl:value-of select="tei:graphic/@url"/></xsl:attribute></img>
			<!--CTF:Vengono generati dei tag a che permettono di visualizzare delle evidenziazioni responsive sulle scansioni. -->
			<xsl:for-each select="tei:zone">
				<a onmouseover="evidenzia(this)" onmouseout="disevidenzia(this)">
					<xsl:attribute name="class"><xsl:value-of select="@xml:id"/></xsl:attribute>
					<xsl:variable name="ulx" select="@ulx"/>
					<xsl:variable name="uly" select="@uly"/>
					<xsl:variable name="lrx" select="@lrx"/>
					<xsl:variable name="lry" select="@lry"/>
					<xsl:variable name="width" select="translate(../tei:graphic/@width, 'px', '')"/>
					<xsl:variable name="height" select="translate(../tei:graphic/@height, 'px', '')"/>
					<xsl:attribute name="style">
						position: absolute; 
						left: <xsl:value-of select="$ulx div $width * 100"/>%; 
						top: <xsl:value-of select="$uly div $height * 100"/>%; 
						width: <xsl:value-of select="($lrx - $ulx) div $width * 100"/>%; 
						height: <xsl:value-of select="($lry - $uly) div $height * 100"/>%;
						<xsl:choose>
							<xsl:when test="@rendition='HotSpot'">
								z-index: 0;
							</xsl:when>
							<xsl:otherwise>
								z-index: 1;
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:if test="@xml:id='LL1.21_hotspot_1fr_01' or @xml:id='LL1.21_hotspot_1fr_02'">
						<xsl:attribute name="href">#<xsl:value-of select="@xml:id"/></xsl:attribute>
					</xsl:if>
				</a>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- CTF:ordina le varie informazioni-->
	<xsl:template match="tei:respStmt">
		<xsl:choose>
			<xsl:when test="tei:name[2]">
				<h3><xsl:value-of select="tei:resp"/>:</h3>
				<ul>
					<xsl:for-each select="tei:name">
						<li>
							<xsl:choose>
								<xsl:when test="@xml:id">
									<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
									<xsl:value-of select="."/><xsl:text>;&#32;</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<a>
										<xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
										<xsl:value-of select="."/>
									</a>
									<xsl:text>;&#32;</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</xsl:for-each>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<p>
					<b><xsl:value-of select="tei:resp"/></b>: 
					<span>
						<xsl:attribute name="id"><xsl:value-of select="tei:name/@xml:id"/></xsl:attribute>
						<xsl:value-of select="tei:name"/>
					</span>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--CTF:divido i vari paratesti-->
	<xsl:template match="tei:div[@type='paratext']">
		<h2>Annotazioni</h2>
		<ul>
			<xsl:for-each select="tei:ab">
				<li>
					<a>
						<xsl:attribute name="class"><xsl:value-of select="translate(@facs, '#', '')"/></xsl:attribute>
						<xsl:attribute name="href"><xsl:value-of select="@hand"/></xsl:attribute>
						<xsl:apply-templates select="."/>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<!--CTF:Aggiunta la parte della bibliografia-->
	<xsl:template match="tei:div[@type='bibliography']">
		<div>
			<xsl:attribute name="id"><xsl:value-of select="tei:listBibl/@xml:id"/></xsl:attribute>
			<h2><xsl:value-of select="tei:listBibl/tei:head"/></h2>
			<ol>
				<xsl:for-each select="tei:listBibl/tei:bibl">
					<li>
						<a onclick="linkaNota(this)">
							<xsl:attribute name="href"><xsl:value-of select="tei:ref/@target"/></xsl:attribute>
							<xsl:attribute name="title">pp. <xsl:value-of select="tei:ref/tei:bibl/tei:citedRange"/></xsl:attribute>
							<xsl:value-of select="tei:ref/tei:bibl/tei:author"/>, <xsl:value-of select="tei:ref/tei:bibl/tei:date"/>
						</a>
					</li>
				</xsl:for-each>
			</ol>
		</div>
	</xsl:template>
	<xsl:template match="tei:listPerson">
	<!--CTF: Viene controllato se l'attributo target contiene più di un link (separati da uno spazio) e vengono generati i tag a di conseguenza -->
		<xsl:choose>
			<xsl:when test="substring-before(tei:persName/tei:ref/@target, ' ')">
				<a>
					<xsl:attribute name="href"><xsl:value-of select="substring-before(tei:persName/tei:ref/@target, ' ')"/></xsl:attribute>
					<xsl:value-of select="substring-before(tei:persName/tei:ref/@target, ' ')"/>
				</a>; 
					<a>
						<xsl:attribute name="href"><xsl:value-of select="substring-after(tei:persName/tei:ref/@target, ' ')"/></xsl:attribute>
						<xsl:value-of select="substring-after(tei:persName/tei:ref/@target, ' ')"/>
					</a>
			</xsl:when>
					<xsl:otherwise>
						<a>
							<xsl:attribute name="href"><xsl:value-of select="tei:persName/tei:ref/@target"/></xsl:attribute>
							<xsl:value-of select="tei:persName/tei:ref/@target"/>
						</a>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	<xsl:template match="tei:body/tei:div">
		<div>
			<xsl:attribute name="id"><xsl:value-of select="@type"/></xsl:attribute>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="tei:lb">
		<xsl:if test="@rend='double stroke'">
			<span class="sub">=</span>
		</xsl:if>
		<xsl:variable name="accapo"><![CDATA[<br/>]]></xsl:variable>
		<xsl:value-of select="$accapo" disable-output-escaping="yes"/>
		<span onmouseover="evidenzia(this)" onmouseout="disevidenzia(this)">
			<xsl:attribute name="class">line <xsl:value-of select="translate(@facs, '#', '')"/></xsl:attribute>
			<xsl:if test="../../@rend='first_line_indented' and count(preceding-sibling::tei:lb)=0 and count(../preceding-sibling::tei:s)=0">
				<xsl:attribute name="style">margin-right: 15%;</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="not(@n > 9)">
					0<xsl:value-of select="@n"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@n"/>
				</xsl:otherwise>
			</xsl:choose>
		</span>
	</xsl:template>
	<xsl:template match="tei:hi">
		<xsl:choose>
			<xsl:when test="@rend='italic'">
				<i><xsl:apply-templates/></i>
			</xsl:when>
			<xsl:when test="@rend='underline'">
				<u><xsl:apply-templates/></u>
			</xsl:when>
			<xsl:when test="@rend='align(center)'">
				<span class="center"><xsl:apply-templates/></span>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tei:g[@rend='superscript']">
		<span class="super"><xsl:apply-templates/></span>
	</xsl:template>
	<xsl:template match="tei:note/tei:p">
		<p>
			<xsl:apply-templates/>
			<xsl:choose>
				<xsl:when test="../@source">
					<a class="super" onclick="linkaNota(this)">
						<xsl:attribute name="href"><xsl:value-of select="../@source"/></xsl:attribute>
						<xsl:if test="..//tei:citedRange">
							<xsl:attribute name="title">pp. <xsl:value-of select="..//tei:citedRange"/></xsl:attribute>
						</xsl:if>fonte
					</a>
				</xsl:when>
				<xsl:when test="../@resp">
					<a class="super">
						<xsl:attribute name="href"><xsl:value-of select="../@resp"/></xsl:attribute>fonte
					</a>
				</xsl:when>
			</xsl:choose>
		</p>
	</xsl:template>
</xsl:stylesheet>