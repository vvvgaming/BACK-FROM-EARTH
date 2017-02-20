void ofApp::setup() {
    // setup OF stuff
    ofSetCircleResolution(50);
    
    // build graph
    //    graph = Graph::buildSimpleGraph();
    //    graph = Graph::buildRandomGraph();
    graph = Graph::buildProductionGraph();
    
    // backref to app
    graph->setApp(this);
}


 





    
    
   
    
   
