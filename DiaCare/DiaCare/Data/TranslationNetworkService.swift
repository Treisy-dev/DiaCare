import Foundation
import Alamofire

final class TranslationNetworkService {
    public static let shared = TranslationNetworkService()

    private init() {
    }

    let translationHeaders: HTTPHeaders = [
        "content-type": "application/json",
        "X-RapidAPI-Key": "9ae964ee58msh2d900e3833aeeb8p1de071jsn8d9ef4e557df",
        "X-RapidAPI-Host": "deep-translate1.p.rapidapi.com"
    ]

    var translationParameters: [String: Any] = [
        "q": "",
        "source": "ru",
        "target": "en"
    ]

    func translateWord(word: String, completion: @escaping (Result<String, Error>) -> Void) {
        makeTranslationRequest(with: word) { result in
            switch result {
            case .success(let word):
                completion(.success(word))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func makeTranslationRequest(with word: String, completion: @escaping (Result<String, Error>) -> Void) {
        translationParameters["q"] = word

        AF.request(
            "https://deep-translate1.p.rapidapi.com/language/translate/v2",
            method: .post,
            parameters: translationParameters,
            encoding: JSONEncoding.default,
            headers: translationHeaders).responseData { response in
            switch response.result {
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(TranslationResponse.self, from: value)
                    let translatedText = result.data.translations.translatedText
                    completion(.success(translatedText))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
