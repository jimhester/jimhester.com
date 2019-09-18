#include <fstream>
#include <string>
#include <Rcpp.h>
#include <map>
#include <set>

using namespace Rcpp;
using namespace std;

vector<string> inline split_string(const string &source, const char delimiter = ' ', bool keep_empty = false) {
  vector<string> results;

  size_t prev = 0;
  size_t next = 0;

  while ((next = source.find_first_of(delimiter, prev)) != string::npos) {
      if (keep_empty || (next - prev != 0)) {
          results.push_back(source.substr(prev, next - prev));
      }
      prev = next + 1;
  }
  if (prev < source.size()) {
      results.push_back(source.substr(prev));
  }

  return results;
}

const uint FIELD_SIZE=8;
const string FIELDS[FIELD_SIZE] = {"seqid", "source", "type", "start", "end", "score", "strand", "phase"};

// [[Rcpp::export]]
Rcpp::DataFrame gff2df(std::string file, const char attribute_sep = '=') {
  CharacterVector records;
  vector< vector < string > > column_strings(FIELD_SIZE);
  vector< map< string, string > > attribute_list;
  set< string > attribute_types;
  ifstream in(file.c_str());
  string rec;
  int count=0;
  while(getline(in,rec)){
    if(rec.at(0) != '#'){ //not a comment line
      vector< string > strings = split_string(rec,'\t');
      for(uint i = 0;i<strings.size()-1;++i){
        column_strings[i].push_back(strings.at(i));
      }
      vector< string > attribute_strings = split_string(strings.at(strings.size()-1), ';');
      map< string, string> line_attributes;
      for(uint i = 0;i< attribute_strings.size();++i){
        vector< string > pair = split_string(attribute_strings.at(i), attribute_sep);
        line_attributes[pair.at(0)] = pair.at(1);
        if(attribute_types.find(pair.at(0)) == attribute_types.end()){
          attribute_types.insert(pair.at(0));
        }
      }
      attribute_list.push_back(line_attributes);
    }
    else if(rec.find("##FASTA") != string::npos){
      break;
    }
    count++;
  }
  Rcpp::DataFrame result;
  for(uint i = 0;i<FIELD_SIZE;++i){
    result[FIELDS[i]]=column_strings.at(i);
  }
  for(set< string >::const_iterator it = attribute_types.begin(); it != attribute_types.end(); ++it){
    vector< string > column_data;
    for(vector< map<string, string > >::const_iterator vec_it = attribute_list.begin();vec_it != attribute_list.end();++vec_it){
      if(vec_it->count(*it) == 1){
        column_data.push_back(vec_it->at(*it));
      }
      else{
        column_data.push_back("NA");
      }
    }
    result[*it]=column_data;
  }
  return(result);
}
