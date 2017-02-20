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

void ofApp::update() {}

void ofApp::draw() {
    // set background gradient
    ofBackgroundGradient(ofColor(64), ofColor(0));
    
    // draw graph
    graph->draw();
    graph->step();
}

void ofApp::keyPressed(int key) {}

void ofApp::keyReleased(int key) {}

void ofApp::mouseMoved(int x, int y) {
    // set center gravity
    if (x < 10) {
        graph->center = false;
    } else if (x > ofGetWindowWidth() - 10) {
        graph->center = true;
    }
    if (y < 10) {
    } else if (y > ofGetWindowHeight() - 10) {
        for (auto ln : graph->getLanguageNodes()) {
            ln->pinned = false;
        }



    
    
   
    
   
