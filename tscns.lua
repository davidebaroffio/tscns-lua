-- @name tscns
	-- @description Outputs the hexadecimal values of the card content
	-- @targets 0.8
	-- Version 1.0
	-- Written by Davide Baroffio
	
	require('lib.apdu')
	if card.connect() then
		CRoot=card.tree_startup("Tessera Sanitaria / Carta Nazionale dei Servizi")
		DF0 = nodes.append(CRoot, {classname="record",label="DF0",val=nil})
		DF1 = nodes.append(CRoot, {classname="record",label="DF1",val=nil})
		DF2 = nodes.append(CRoot, {classname="record",label="DF2",val=nil})
		card.send(bytes.new(8, "00 A4 00 00 02 3F 00"))
		card.send(bytes.new(8, "00 A4 00 00 02 10 00"))
		card.send(bytes.new(8, "00 A4 00 00 02 10 02"))
		sw, resp = card.read_binary('.')
		nodes.append(DF0, {classname="file",label="EF.Dati_processore",val=tostring(resp)})
		card.send(bytes.new(8, "00 A4 00 00 02 10 03"))
		sw, resp = card.read_binary('.')
		nodes.append(DF0, {classname="file",label="EF.ID_Carta",val=tostring(resp)})
		card.send(bytes.new(8, "00 A4 00 00 02 3F 00"))
		card.send(bytes.new(8, "00 A4 00 00 02 11 00"))
		card.send(bytes.new(8, "00 A4 00 00 02 11 01"))
		sw, resp = card.read_binary('.')
		nodes.append(DF1, {classname="file",label="EF.C_Carta",val=tostring(resp)})
		card.send(bytes.new(8, "00 A4 00 00 02 11 02"))
		sw, resp = card.read_binary('.')
		nodes.append(DF1, {classname="file",label="EF_Dati_personali",val=tostring(resp)})
		card.send(bytes.new(8, "00 A4 00 00 02 3F 00"))
		card.send(bytes.new(8, "00 A4 00 00 02 12 00"))
		card.send(bytes.new(8, "00 A4 00 00 02 12 01"))
		sw, resp = card.read_binary('.')
		nodes.append(DF2, {classname="file",label="EF.Dati_personali_aggiuntivi",val=tostring(resp)})
		card.send(bytes.new(8, "00 A4 00 00 02 12 02"))
		sw, resp = card.read_binary('.')
		nodes.append(DF2, {classname="file",label="EF.Memoria_residua",val=tostring(resp)})
		card.send(bytes.new(8, "00 A4 00 00 02 12 03"))
		sw, resp = card.read_binary('.')
		nodes.append(DF2, {classname="file",label="EF.Servizi installati",val=tostring(resp)})
		card.disconnect()
end