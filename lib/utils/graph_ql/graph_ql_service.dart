import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_app/core/model/error_model.dart';
import 'package:todo_app/core/model/success_model.dart';

class graphQlService {
  static HttpLink httpLink = HttpLink(
    'https://todolistassessment.hasura.app/v1/graphql',
    defaultHeaders: <String, String>{
      'x-hasura-admin-secret':
          'JG7vDm15n1fVT2QhwYNyDFJJmm5iQKIea3H0tVpYnNV735Wa2ms3msthBGquM2sm',
      'content-type': 'application/json'
    },
  );
  // static final AuthLink authLink = AuthLink(
  //   getToken: () => 'Bearer $tokenUniversal',
  // );

  static String print(String input) {
    var text = input;
    return text;
  }

  final Link link = httpLink;

  // ValueNotifier<GraphQLClient> client = ValueNotifier(
  //     // cache: InMemoryCache(),
  //     GraphQLClient(
  //   cache: GraphQLCache(),
  //   link: httpLink,
  // ));

  // static ValueNotifier<GraphQLClient> initailizeClient() {
  //   ValueNotifier<GraphQLClient> client = ValueNotifier(
  //     GraphQLClient(
  //       cache: GraphQLCache(),
  //       link: httpLink,
  //     ),
  //   );

  //   return client;
  // }

  GraphQLClient clientToQuery() {
    return GraphQLClient(link: link, cache: GraphQLCache());
  }

  // ignore: missing_return
  gpMutate({
    @required String? mutationDocument,
    Map<String, dynamic>? data,
  }) async {
    try {
      QueryResult queryResult;
      queryResult = await clientToQuery().mutate(MutationOptions(
        document: gql(mutationDocument!),
        variables: data!,
      ));

      if (queryResult.hasException) {
        // print(queryResult.exception);
        return ErrorModel(queryResult.exception.toString());
      } else {
        // print(queryResult.data);
        return SuccessModel(queryResult.data);
      }
    } catch (e) {
      log('Error $e');
      return ErrorModel(e);
    }
  }

  // ignore: missing_return
  gpQuery({
    @required String? queryDocument,
    Map<String, dynamic>? data,
  }) async {
    try {
      QueryResult queryResult = await clientToQuery().query(QueryOptions(
        document: gql(queryDocument!),
        variables: data!,
      ));
      if (queryResult.hasException) {
        return ErrorModel(queryResult.exception.toString());
      } else {
        return SuccessModel(queryResult.data);
      }
    } catch (e) {
      log('Error $e');
      return ErrorModel(e);
    }
  }
}
