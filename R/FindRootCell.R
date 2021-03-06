#' Find the root cell
#'
#' Use either the primary manifold embedding of cell similarity to find the root cell by cluster-cell rank-correlation or use the flattened representation of this embedding to find the root cell by maximum separation heuristic.
#' Possible values for cluster_order_by are predecessor and distance.
#' Possible values for cell_order_by are index and distance.
#'
#' @param use_flat_dist use max path length heuristic on flat embedding
#' @param cluster_order_by cluster rank parameter for measuring cluster/cell rank correlation
#' @param cell_order_by cell-wise pseudotime parameter for measuring cluster/cell rank correlation
#' @param graph_cluster_mst igraph object representing an mst on the cluster-cluster graph
#' @param dist_graph a distance matrix of cells embedded in a graph
#' @param dist_flat the manifold embedding of the cells
#' @param cluster_labels the cluster label for each cell
#' @param root_cluster the id of the root cluster on the cluster-cluster graph
#'
#' @return integer index of the root cell
#'
#' @export
#'
FindRootCell <- function(use_flat_dist = TRUE,
                         cluster_order_by = "distance",
                         cell_order_by = "distance",
                         graph_cluster_mst = NULL,
                         dist_graph  = NULL,
                         dist_flat,
                         cluster_labels = NULL,
                         root_cluster = NULL){
  if(use_flat_dist){
    xy <- which(dist_flat == max(dist_flat), arr.ind = TRUE)
    max_cells <- sort(unique(as.vector(which(dist_flat == max(dist_flat), arr.ind = TRUE))))
    return(max_cells[length(max_cells)])
  } else {
    n_clusters <- length(unique(cluster_labels))
    root_cluster_cells <- which(cluster_labels == root_cluster, arr.ind = TRUE)

    tau_score <- rep(0, length(root_cluster_cells))
    avg_ptime_to_clusters <- matrix(0, length(root_cluster_cells), n_clusters)
    for(i in 1:length(root_cluster_cells)){
      for(j in 1:n_clusters){
        avg_ptime_to_clusters[i,j] <- GetCellMetric(cell_order_by, i, j, cluster_labels, dist_graph)
      }
      avg_ptime_to_clusters[i,] <- avg_ptime_to_clusters[i,] / max(avg_ptime_to_clusters[i,])
      tau_score[i] <- GetCorrelation(cluster_order_by, avg_ptime_to_clusters[i,], graph_cluster_mst, root_cluster)
    }
    winner <- which(tau_score == min(tau_score))
    if(length(winner > 1)){
      winner = winner[1]
    }
    root_cell <- root_cluster_cells[winner]
    return(root_cell)
  }
}

#' Get rank correlation
#'
#' Get rank correlation for pseudotime analysis
#'
#' @param cluster_order_by cluster rank parameter for measuring cluster/cell rank correlation
#' @param cell_metric either distance or index
#' @param graph_cluster_mst igraph object representing an mst on the cluster-cluster graph
#' @param root_cluster the id of the root cluster on the cluster-cluster graph
#'
#' @importFrom igraph shortest.paths
#' @importFrom stats cor
#'
#' @return tau score of rank correlation
#'
GetCorrelation <- function(cluster_order_by, cell_metric, graph_cluster_mst, root_cluster){
  if(cluster_order_by == "distance"){
    path_lengths <- shortest.paths(graph = graph_cluster_mst, v = root_cluster) + 1
    tau <- cor(as.vector(path_lengths/max(path_lengths)), cell_metric, method = "kendall")
  } else if (cluster_order_by == "predecessor"){
    predecessors <- GetPredecessors(graph_cluster_mst, root_cluster) + 1
    tau <- cor(predecessors/max(predecessors), cell_metric, method = "kendall")
  }
}

#' Get metric of pseudotime
#'
#' Measure pseudotime from the given cell to its cluster partners.
#'
#' @param cell_order_by cell-wise pseudotime parameter for measuring cluster/cell rank correlation
#' @param cell_id the cell to measure from
#' @param cluster_id the cluster of the cell
#' @param cluster_labels the cluster label for each cell
#' @param dist_graph a distance matrix of cells embedded in a graph
#'
#' @return the mean distance (by given metric) from the given cell
#'
GetCellMetric <- function(cell_order_by, cell_id, cluster_id, cluster_labels, dist_graph){
  cells_in_cluster <- which(cluster_labels == cluster_id, arr.ind = TRUE)
  if(cell_order_by == "distance"){
    return(mean(dist_graph[cell_id, cells_in_cluster]))
  } else if (cell_order_by == "index"){
    return(mean(cells_in_cluster))
  }
}
