#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int id;
    double vector[3];
} Embedding;

double euclidean_distance(double *a, double *b, int dim) {
    double sum = 0.0;
    for (int i = 0; i < dim; i++) {
        double diff = a[i] - b[i];
        sum += diff * diff;
    }
    return sqrt(sum);
}

int main() {
    printf("PostgreSQL Vector Database Simulation\n");
    printf("=====================================\n\n");
    
    // Simulate pgvector extension enabled
    printf("[✓] pgvector extension enabled\n");
    printf("[✓] Table 'embeddings' created with vector(3) column\n\n");
    
    // Sample embeddings (simulating database records)
    Embedding embeddings[] = {
        {1, {1.0, 2.0, 3.0}},
        {2, {4.0, 5.0, 6.0}},
        {3, {7.0, 8.0, 9.0}}
    };
    int num_embeddings = 3;
    
    printf("[✓] Inserted %d sample vector embeddings\n\n", num_embeddings);
    
    // Query vector (simulating nearest neighbor search)
    double query[3] = {2.0, 3.0, 4.0};
    
    printf("Searching for nearest neighbor to query vector: [%.1f, %.1f, %.1f]\n\n", 
           query[0], query[1], query[2]);
    
    // Calculate distances and find nearest
    double min_distance = INFINITY;
    int nearest_id = -1;
    
    printf("Distance calculations:\n");
    for (int i = 0; i < num_embeddings; i++) {
        double dist = euclidean_distance(query, embeddings[i].vector, 3);
        printf("  ID %d [%.1f, %.1f, %.1f] -> distance: %.6f\n", 
               embeddings[i].id, 
               embeddings[i].vector[0], embeddings[i].vector[1], embeddings[i].vector[2],
               dist);
        
        if (dist < min_distance) {
            min_distance = dist;
            nearest_id = embeddings[i].id;
        }
    }
    
    printf("\n[✓] Nearest Neighbor Result:\n");
    printf("    ID: %d\n", nearest_id);
    printf("    Distance: %.6f\n", min_distance);
    printf("\n[✓] Vector similarity search completed successfully!\n");
    
    return 0;
}
