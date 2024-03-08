import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<String> encodeImage(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Future<GenerateContentResponse> sendMessageGPT({required String diseaseName}) async {
    final apiKey = API_GEMINI;
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [
      Content.text(
          'Upon receiving the name of a plant disease, provide three precautionary measures to prevent or manage the disease. These measures should be concise, clear, and limited to one sentence each. No additional information or context is needed—only the three precautions in bullet-point format. The disease is $diseaseName')
    ];
    return model.generateContent(content);
  }

  Future<GenerateContentResponse> sendImageToGPT4Vision({
    required File image,
    int maxTokens = 50,
  }) async {
    final apiKey = API_GEMINI;
    final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
    final firstImage = await (image.readAsBytes());
    final prompt = TextPart(
        'Gemini, your task is to identify plant health issues with precision. Analyze any image of a plant or leaf I provide, and detect all abnormal conditions, whether they are diseases, pests, deficiencies, or decay. Respond strictly with the name of the condition identified, and nothing else—no explanations, no additional text. If a condition is unrecognizable, reply with \'I don\'t know\'. If the image is not plant-related, say \'Please pick another image\'');
    final imageParts = [
      DataPart('image/jpeg', firstImage),
    ];
    return model.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
  }
}
