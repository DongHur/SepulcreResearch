function WriteCorrToGEXF (data, gene_names, row_idx, export_filename)
%% WriteCorrToGEXF Parameter
% data=AllenBrain_FreesurferROIs_corr_ADGeneticRiskNetwork;
%
% gene_names=AllenBrain_genesnames;
%
% row_idx=ADgenes_AllenBrain_genesnames_location;
% *** row_idx are all the indices of the gene of interest on the original
% matrix (the index of the genes on the rows)
%
% export_filename="GeneNetwork"
%
% DISCUSSION: This function helps convert the genes of interest correlation
% matrix to .gexf format. This format allows you to create a data set that
% can be inserted into Gephi create an nice, visual network.
% 
%%
[dim_x, dim_y]=size(data);
% find linkages (edges)
[i,j]=find(data~=0);
i_length=length(i);
% finds genes that have nonzero edges
interested_nodes=union(row_idx, j);

% initiate waitbar
f=waitbar(0,'1','Name','Creating GEXF Doc',...
    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(f,'canceling',0);

% initiates gexf doc
docNode=com.mathworks.xml.XMLUtils.createDocument('gexf');
docRootNode=docNode.getDocumentElement;
    docRootNode.setAttribute('xmlns','http://www.gexf.net/1.1draft');
    docRootNode.setAttribute('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
    docRootNode.setAttribute('xsi:schemaLocation','http://www.gexf.net/1.1draft http://www.gexf.net/1.1draft/gexf.xsd');
    docRootNode.setAttribute('version','1.1');

% creates graph node
graph_node=docNode.createElement('graph');
    graph_node.setAttribute('mode', 'static');
    graph_node.setAttribute('defaultedgetype', 'undirected');
    docNode.getDocumentElement.appendChild(graph_node);

% creates nodes and edges node
nodes_node=docNode.createElement('nodes');
    graph_node.appendChild(nodes_node);
edges_node=docNode.createElement('edges');
    graph_node.appendChild(edges_node);


% recursively creates node elements inside nodes node
for idx = 1:length(interested_nodes)
    if getappdata(f,'canceling')
        break
    end
    waitbar(idx/dim_y,f,sprintf('Writing nodes element: %3.1f',100*idx/dim_y))
    % create node
    node_node=docNode.createElement('node');
        node_node.setAttribute('id', num2str(interested_nodes(idx)));
        node_node.setAttribute('label', gene_names(interested_nodes(idx)));
        nodes_node.appendChild(node_node);
end

% recursively creates edge elements inside edges node
for idx = 1:length(i)
    if getappdata(f,'canceling')
        break
    end
    waitbar(idx/length(i),f,sprintf('Writing edges element: %3.1f',100*idx/length(i)))
    % create node
    edge_node=docNode.createElement('edge');
        edge_node.setAttribute('id', num2str(idx));
        edge_node.setAttribute('source', num2str(row_idx(i(idx))));
        edge_node.setAttribute('target', num2str(j(idx)));
        edge_node.setAttribute('weight', num2str(data(i(idx),j(idx))));
        edges_node.appendChild(edge_node);
end

% create and save gexf/xml file
xmlFileName=[export_filename ,'.gexf'];
xmlwrite(xmlFileName,docNode);
edit(xmlFileName);
% delete waitbar
delete(f)







